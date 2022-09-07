# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

src_compile() {
	emake c.info c.html $(usev pdf 'c.pdf')
}

src_install() {
	docinto html
	dodoc -r .html/.

	#local manual
	#for manual in c c-* ; do
	#	num=${manual/c-}
	#
	#	if [[ ${num} != c ]] ; then
	#		mv ${manual} c.info-${num} || die
	#		doinfo c.info-${num}
	#	else
	#		mv ${manual} ${manual}.info || die
	#		doinfo ${manual}.info
	#	fi
	#done

	local manual
	for manual in c c-* ; do
		doinfo ${manual}
	done

	if use pdf ; then
		docinto pdf
		dodoc c.pdf
	fi
}
