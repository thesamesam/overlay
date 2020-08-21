# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="ZNC module for per-client buffers"
HOMEPAGE="https://github.com/CyberShadow/znc-clientbuffer https://wiki.znc.in/Clientbuffer"
SRC_URI="https://github.com/CyberShadow/znc-clientbuffer/archive/v1.0.48.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# For now, depend on a fixed version of net-irc/znc
# But really, it needs a subslot:
# "If you upgrade your ZNC version you must recompile all your modules."
# - https://wiki.znc.in/Compiling_modules
RDEPEND="~net-irc/znc-1.8.1"
DEPEND="${RDEPEND}"

_emake() {
	DESTDIR="${ED}" PREFIX="/usr/" LIBDIR="$(get_libdir)" emake "$@"
}

src_compile() {
	# There is only one source file.
	_emake -j1
}

src_install() {
	_emake install
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "Please add ${ED}/usr/$(get_libdir)/znc/modules/clientbuffer.so to your ZNC config."
	fi
}
