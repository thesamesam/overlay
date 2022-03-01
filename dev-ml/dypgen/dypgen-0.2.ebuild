# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="dypgen parser generator"
HOMEPAGE="http://dypgen.free.fr/"
# Use fork to build w/ new OCaml (same as what pfff ends up using, which is why we added this pkg)
SRC_URI="https://github.com/grain-lang/dypgen/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CeCILL-B"
SLOT="0/${PV}"
KEYWORDS="~amd64"

MAKEOPTS+=" -j1"
