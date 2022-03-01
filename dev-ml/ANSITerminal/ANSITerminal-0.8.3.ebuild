# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Basic control of ANSI compliant terminals and the windows shell"
HOMEPAGE="https://github.com/Chris00/ANSITerminal"
SRC_URI="https://github.com/Chris00/ANSITerminal/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-3-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
