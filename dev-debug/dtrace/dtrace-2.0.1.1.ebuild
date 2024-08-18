# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic linux-info toolchain-funcs udev

DESCRIPTION="Dynamic systemwide tracing tool"
HOMEPAGE="https://github.com/oracle/dtrace-utils"

if [[ ${PV} == 9999 ]]; then
	EGIT_BRANCH="devel"
	EGIT_REPO_URI="https://github.com/oracle/dtrace-utils"
	inherit git-r3
else
	SRC_URI="https://github.com/oracle/dtrace-utils/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/dtrace-utils-${PV}

	KEYWORDS="-* ~amd64"
fi

LICENSE="UPL-1.0"
SLOT="0"
IUSE="systemd test"

# XXX: right now, we auto-adapt to whether multilibs are present:
# should we force them to be? how?
# binutils-libs will need an extra patch for what dtrace does with
# it in the absence of in-kernel CTF: it will be backported
# to 2.42, but perhaps a patch would be a good idea before that?
COMMON_DEPEND="
	dev-build/make
	dev-libs/elfutils
	dev-libs/libpfm:=
	net-analyzer/wireshark[dumpcap]
	net-libs/libpcap
	sys-devel/gcc
	>=sys-fs/fuse-3.2.0:3
	>=sys-libs/binutils-libs-2.42:=
	sys-libs/zlib
	systemd? ( sys-apps/systemd )
"
BDEPEND="
	${COMMON_DEPEND}
	dev-libs/libbpf
	>=sys-devel/bpf-toolchain-14.1.0
	sys-apps/gawk
	sys-devel/bison
	sys-devel/flex
"
RDEPEND="
	!dev-debug/systemtap
	${COMMON_DEPEND}
	net-analyzer/wireshark
	test? (
		app-alternatives/bc
		app-editors/vim-core
		dev-build/make
		dev-lang/perl
		dev-util/perf
		net-fs/nfs-utils
		sys-apps/coreutils
		sys-fs/xfsprogs
		sys-process/time
		virtual/jdk
		virtual/perl-IO-Socket-IP
	)
"

pkg_pretend() {
	# XXX: Should we just drop a config fragment in place (???)
	# We do have actual kernel patches we'd like to apply, after all.
	#
	# TODO: kernel patches

	# Basics for debugging information, BPF
	local CONFIG_CHECK="~BPF ~DEBUG_INFO_BTF ~KALLSYMS_ALL ~CUSE"

	# Tracing
	# TODO: CONFIG_HAVE_SYSCALL_TRACEPOINTS - is it auto?
	# TODO: CONFIG_UPROBE_EVENTS maybe?
	CONFIG_CHECK+=" ~FTRACE_SYSCALLS ~UPROBE_EVENTS ~DYNAMIC_FTRACE ~FUNCTION_TRACER"

	# https://gcc.gnu.org/PR84052
	CONFIG_CHECK+=" !GCC_PLUGIN_RANDSTRUCT"

	check_extra_config
}

pkg_setup() {
	eval unset ${!LC_*} LANG
}

src_configure() {
	if tc-is-cross-compiler; then
		die "DTrace does not yet support cross-compilation."
	fi

	tc-export CC

	# TODO: Can drop once https://lore.kernel.org/dtrace/20240425164057.420580-1-nick.alcock@oracle.com/ is in
	tc-enables-fortify-source && append-cppflags -U_FORTIFY_SOURCE

	# lld does this by default, so fix that, although lld fails anyway...
	# 'LIBDTRACE_1.0' to symbol 'dtrace_provider_modules' failed: symbol not defined
	append-ldflags $(test-flags-CCLD -Wl,--undefined-version)
	# mold and lld can't cope with some relocation types used, e.g.
	#  'test-triggers--usdt-tst-forker-prov.o:(.SUNW_dof): unknown relocation: R_X86_64_GLOB_DAT'
	tc-ld-force-bfd

	# -fno-semantic-interposition seems to lead to a broken dtrace
	# that can't actually obtain results from probes, even trivial examples
	# just hang.
	filter-flags -fno-semantic-interposition
	filter-lto

	local confargs=(
		# TODO: Maybe we should set the UNPRIV_UID to something? -3 is a bit... kludgy
		--prefix="${EPREFIX}"/usr
		--mandir="${EPREFIX}"/usr/share/man
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		HAVE_LIBCTF=yes
		HAVE_LIBSYSTEMD=$(usex systemd)
		HAVE_BPFV3=yes
	)

	edo ./configure "${confargs[@]}"
}

src_compile() {
	emake verbose=1 $(usev !test TRIGGERS='')
}

src_test() {
	# XXX: can't yet, needs root: make a testsuite package instead
	# TODO: figure out policy/convention on installing tests
	:;
}

src_install() {
	emake DESTDIR="${D}" install $(usev test install-test)

	# Stripping the BPF libs breaks them
	dostrip -x "/usr/$(get_libdir)"

	# It's a binary (TODO: move it?)
	docompress -x /usr/share/doc/${PF}/showUSDT

	# In the absence of systemd, install the openrc init script.
	# The unit will not be installed (it wouldn't work, since it uses
	# Type=notify).
	# dtprobed when not under systemd or foregrounded logs errors
	# to syslog:
	# XXX: shouldn't we ensure there *is* a logger, somehow?
	if ! use systemd; then
		doinitd "${FILESDIR}"/openrc/dtprobed
	fi
}

pkg_postinst() {
	# We need a udev reload to pick up the CUSE device node rules;
	# we need to start dtprobed, if not already running, and restart
	# it on upgrade (it will carry across its own persistent state)
	udev_reload

	if [[ -n ${REPLACING_VERSIONS} ]]; then
		if [ -x /etc/init.d/dtprobed ]; then
			/etc/init.d/dtprobed stop || :
			/etc/init.d/dtprobed start
		elif type systemctl &>/dev/null; then
			systemctl restart dtprobed
		fi
	else
		if type rc_update &>/dev/null; then
			rc_update add dtprobed || :
		elif type systemctl &>/dev/null; then
			systemctl enable dtprobed
			systemctl start dtprobed
		fi
	fi

	# TODO: What happens on uninstallation?
}
