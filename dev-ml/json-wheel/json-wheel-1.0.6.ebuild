# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="JSON parser and writer, with optional C-style comments"
HOMEPAGE="https://opam.ocaml.org/packages/json-wheel/"
SRC_URI="https://github.com/mjambon/mjambon2016/raw/master/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocamlnet:="
DEPEND="${RDEPEND}"

MAKEOPTS+=" -j1"

PATCHES=(
	"${FILESDIR}"/${P}-safe-string.patch
)

src_install() {
	dodir /usr/bin

	findlib_src_install BINDIR="${D}/${EPREFIX}"/usr/bin
}
