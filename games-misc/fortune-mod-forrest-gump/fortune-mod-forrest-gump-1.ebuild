# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A collection of quotes from the movie Forrest Gump"
HOMEPAGE="https://www.splitbrain.org/projects/fortunes/fgump"
SRC_URI="https://www.splitbrain.org/_media/projects/fortunes/fortune-fgump.tgz"
S="${WORKDIR}"/fortune-fgump

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins fgump fgump.dat
}
