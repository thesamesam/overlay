# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Lossless data compression maximizing compression ratio"
HOMEPAGE="http://www.byronknoll.com/cmix.html"
# Missing 19.1
#SRC_URI="http://www.byronknoll.com/cmix-v19.zip"
SRC_URI="https://github.com/byronknoll/cmix/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="custom-cflags"

PATCHES=(
	"${FILESDIR}"/${PN}-19-makefile.patch
	"${FILESDIR}"/${PN}-19-printf-include.patch
)

src_configure() {
	# See discussion in README (bit scary, but...)
	# "Compile with "-Ofast -march=native" for fastest performance.
	#  These compiler options might lead to incompatibility between
	#  different computers due to floating-point precision differences.
	#  Compile with "-O3" to fix compatibility issues (at the cost of slower
	#  performance)."
	use custom-cflags || append-cxxflags "-Ofast"
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs

	dobin cmix enwik9-preproc

	insinto /usr/share/cmix
	doins -r dictionary
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "Use of enwik9 preprocessing via enwik9-preproc requires a dictionary."
		elog "The dictionary files are installed to ${EROOT}/usr/share/cmix/dictionary."
	fi
}
