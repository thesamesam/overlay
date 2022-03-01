# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml interface to the YAML 1.1 spec"
HOMEPAGE="https://github.com/avsm/ocaml-yaml"
SRC_URI="https://github.com/avsm/ocaml-yaml/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

# TODO: tests
RDEPEND="dev-ml/bos:=
	dev-ml/ocaml-ctypes:=[ocamlopt?]
	dev-ml/sexplib:=[ocamlopt?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-ml/dune-configurator"
