# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Lightweight C++ command line option parser"
HOMEPAGE="https://github.com/jarro2783/cxxopts"
SRC_URI="https://github.com/jarro2783/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE="test"

src_configure() {
	local mycmakeopts=(
		-DCXXOPTS_BUILD_TESTS="$(usex test)"
	)

	cmake_src_configure
}
