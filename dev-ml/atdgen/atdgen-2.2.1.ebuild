# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Static types for JSON APIs"
HOMEPAGE="https://github.com/ahrefs/atd"
SRC_URI="https://github.com/ahrefs/atd/releases/download/${PV}/${P/gen/}.tbz"
S="${WORKDIR}/${P/gen/}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

# TODO: tests
RDEPEND="dev-ml/biniou:=
	dev-ml/easy-format:=
	dev-ml/menhir:=
	dev-ml/re:=
	dev-ml/yojson:="
DEPEND="${RDEPEND}"

src_install() {
	dune-install ${PN} atdgen-runtime
}
