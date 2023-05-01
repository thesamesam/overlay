# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A love letter to the golden era of computing"
HOMEPAGE="https://berkeleygraphics.com/typefaces/berkeley-mono/"
SRC_URI="berkeley-mono-typeface-${PV}.zip"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"
RESTRICT="fetch"

BDEPEND="app-arch/unzip"

src_install() {
	FONT_PN=BerkeleyMono \
		FONT_S=berkeley-mono/OTF \
		FONT_SUFFIX=otf \
		FONTDIR="${EPREFIX}"/usr/share/fonts/BerkeleyMono
		font_src_install

	FONT_PN=BerkeleyMonoVariable \
		FONT_S=berkeley-mono-variable/TTF \
		FONT_SUFFIX=ttf \
		FONTDIR="${EPREFIX}"/usr/share/fonts/BerkeleyMonoVariable
		font_src_install
}
