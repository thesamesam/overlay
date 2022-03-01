# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="simple, lightweight library for creating and processing background jobs"
HOMEPAGE="https://python-rq.org https://github.com/rq/rq"
SRC_URI="https://github.com/returntocorp/semgrep/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/-core/}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ocamlopt"

# Missing: atdgen, ppx_hash, lsp, comby-kernel
RDEPEND="dev-ml/ppx_deriving:=
	dev-ml/ppx_hash:=
	dev-ml/pcre-ocaml:=
	dev-ml/yojson:=
	dev-ml/uucp:=
	dev-ml/re:=
	dev-ml/parmap:=
	dev-ml/ppxlib:=
	dev-ml/yaml:="
