# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of quotes from opening credits of The Simpsons"
HOMEPAGE="https://www.splitbrain.org/projects/fortunes/simpsons"
SRC_URI="https://www.splitbrain.org/_media/projects/fortunes/fortune-simpsons-chalkboard.tgz"
S="${WORKDIR}"/fortune-simpsons-chalkboard

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc64 ~riscv ~sparc ~x86"

RDEPEND="games-misc/fortune-mod"

src_install() {
	dodoc README

	insinto /usr/share/fortune
	doins chalkboard chalkboard.dat
}
