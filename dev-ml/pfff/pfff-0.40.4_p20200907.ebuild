# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

MY_COMMIT="a9457ae5729de4e7737331e68a98c8d564701841"
DESCRIPTION="pfff is a set of tools and APIs to perform static analysis"
HOMEPAGE="https://github.com/returntocorp/pfff"
SRC_URI="https://github.com/returntocorp/pfff/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/${PN}-${MY_COMMIT}

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="<dev-lang/ocaml-4.12:=
	dev-ml/dypgen:=
	dev-ml/json-wheel:=
	=dev-ml/ppxlib-0.20*:=
	dev-ml/uutf:="
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-fix-dune-O3.patch
)

src_configure() {
	./configure --no-visual --no-bytecode --no-cmt || die
}
