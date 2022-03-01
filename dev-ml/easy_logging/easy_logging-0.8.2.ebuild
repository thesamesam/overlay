# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Logging module for OCaml"
HOMEPAGE="https://sapristi.github.io/easy_logging/"
SRC_URI="https://github.com/sapristi/easy_logging/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-ml/calendar:=
	dev-ml/ppx_deriving_yojson:="
DEPEND="${RDEPEND}"

src_install() {
	dune-install ${PN} easy_logging_yojson
}
