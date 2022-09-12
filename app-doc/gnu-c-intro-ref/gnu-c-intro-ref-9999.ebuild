# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GNU C Language Intro and Reference Manual"
HOMEPAGE="https://savannah.gnu.org/projects/c-intro-and-ref/"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/c-intro-and-ref.git"
	inherit git-r3
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="FDL-1.3+"
SLOT="0"
IUSE="pdf"

BDEPEND="
	sys-apps/texinfo
	pdf? (
		app-text/ghostscript-gpl
		app-text/texlive-core
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-9999-autotools.patch
)

src_prepare() {
	default

	eautoreconf
}

src_compile() {
	emake info html $(usev pdf 'pdf')
}

src_install() {
	emake DESTDIR="${D}" install-info install-html $(usev pdf 'install-pdf')
}
