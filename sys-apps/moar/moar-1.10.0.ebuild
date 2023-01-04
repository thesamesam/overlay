# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="Moar is a pager. It's designed to just do the right thing without any configuration."
HOMEPAGE="https://github.com/walles/moar"

SRC_URI=" https://github.com/walles/moar/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dev.gentoo.org/~sam/distfiles/${CATEGORY}/${PN}/${P}-deps.tar.xz"

# TODO
LICENSE="MIT BSD-with-disclosure"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

src_compile() {
	# https://github.com/walles/moar/blob/master/build.sh#L28
	ego build -ldflags="-s -w -X main.versionString=${PV}" -o moar
}

src_install() {
	dobin moar

	einstalldocs
}
