# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo cargo

DESCRIPTION="Highly experimental tooling ecosystem for Gentoo"
HOMEPAGE="https://pkgcraft.github.io/"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcraft/pkgcraft"
	inherit git-r3
else
	SRC_URI="https://github.com/pkgcraft/pkgcraft/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# TODO: fix LICENSE
LICENSE="BSD-1"
SLOT="0/${PV}"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-util/cargo-c
	>=virtual/rust-1.65
	test? ( dev-util/cargo-nextest )
"

QA_FLAGS_IGNORED="usr/lib.*/libpkgcraft.so.*"

src_unpack() {
	if [[ ${PV} == 9999 ]] ; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		default
	fi
}

src_compile() {
	local cargoargs=(
		--library-type=cdylib
		--prefix=/usr
		--libdir="/usr/$(get_libdir)"
	)

	edo cargo cbuild "${cargoargs[@]}"
}

src_test() {
	# Need nextest per README (separate processes required)
	# Invocation from https://github.com/pkgcraft/pkgcraft/blob/main/.github/workflows/ci.yml#L56
	edo cargo nextest run --color always --all-features
}

src_install() {
	local cargoargs=(
		--library-type=cdylib
		--prefix=/usr
		--libdir="/usr/$(get_libdir)"
		--destdir="${ED}"
	)

	edo cargo cinstall "${cargoargs[@]}"
}
