# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info toolchain-funcs systemd

DESCRIPTION="bpftune uses BPF to auto-tune Linux systems"
HOMEPAGE="https://github.com/oracle/bpftune"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/oracle/bpftune.git"
	inherit git-r3
else
	BPFTUNE_COMMIT="04c7d79ab62b872459d878ceb4fab40477da8103"
	SRC_URI="https://github.com/oracle/bpftune/archive/${BPFTUNE_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${BPFTUNE_COMMIT}

	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="clang"
RESTRICT="test" # The tests require root.

DEPEND="
	dev-libs/libbpf:=
	dev-libs/libnl
	sys-libs/libcap
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/bpftool
	dev-util/pahole
	clang? ( llvm-core/clang:* )
	!clang? ( sys-devel/bpf-toolchain )
"

PATCHES=(
	"${FILESDIR}"/add-init-script.patch
)

pkg_setup() {
	CONFIG_CHECK="DEBUG_INFO_BTF"
	check_extra_config
}

src_configure() {
	tc-export CC

	! use clang && export GCC_BPF=bpf-unknown-none-gcc
}

src_install() {
	default
	systemd_dounit src/bpftune.service
}
