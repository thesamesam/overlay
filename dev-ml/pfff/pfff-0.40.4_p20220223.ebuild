# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

MY_COMMIT="a463f4374de645cd2e05d16e7f4de5e0bcfbe7d9"
DESCRIPTION="pfff is a set of tools and APIs to perform static analysis"
HOMEPAGE="https://github.com/returntocorp/pfff"
SRC_URI="https://github.com/returntocorp/pfff/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/${PN}-${MY_COMMIT}

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="<dev-lang/ocaml-4.12:=
	dev-ml/ANSITerminal:=
	dev-ml/dypgen:=
	dev-ml/json-wheel:=
	=dev-ml/ppxlib-0.20*:=
	dev-ml/uutf:="
DEPEND="${RDEPEND}"

src_configure() {
	./configure --no-visual --no-bytecode --no-cmt || die
}

src_install() {
	local pkgs=(
commons_core.opam
commons_ocollection.opam
commons.opam
pfff-commons-graph.opam
pfff-config.opam
pfff-graph_code.opam
pfff-h_files-format.opam
pfff-h_program-lang.opam
pfff-lang_c-analyze.opam
pfff-lang_c.opam
pfff-lang_cpp-analyze.opam
pfff-lang_cpp.opam
pfff-lang_csharp-analyze.opam
pfff-lang_csharp.opam
pfff-lang_erlang-analyze.opam
pfff-lang_erlang.opam
pfff-lang_FUZZY.opam
pfff-lang_go-analyze.opam
pfff-lang_go.opam
pfff-lang_haskell-analyze.opam
pfff-lang_haskell.opam
pfff-lang_html-analyze.opam
pfff-lang_html.opam
pfff-lang_java-analyze.opam
pfff-lang_java.opam
pfff-lang_js-analyze.opam
pfff-lang_json.opam
pfff-lang_js.opam
pfff-lang_lisp-analyze.opam
pfff-lang_lisp.opam
pfff-lang_ml-analyze.opam
pfff-lang_ml.opam
pfff-lang_nw-analyze.opam
pfff-lang_nw.opam
pfff-lang_php-analyze.opam
pfff-lang_php-checker.opam
pfff-lang_php.opam
pfff-lang_php-visual.opam
pfff-lang_python-analyze.opam
pfff-lang_python.opam
pfff-lang_regexp.opam
pfff-lang_ruby-analyze.opam
pfff-lang_ruby.opam
pfff-lang_rust-analyze.opam
pfff-lang_rust.opam
pfff-lang_scala-analyze.opam
pfff-lang_scala.opam
pfff-lang_skip-analyze.opam
pfff-lang_skip.opam
pfff-lang_text.opam
pfff.opam
pfff-testutil.opam
ppx_profiling.opam
	)

	local pkg
	for pkg in "${pkgs[@]}" ; do
		dune-install ${pkg/.opam/}
	done
}
