# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="ldd as a tree with an option to bundle dependencies into a single folder"
HOMEPAGE="https://github.com/haampie/libtree"
SRC_URI="https://github.com/haampie/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Integration test fails (because of library path?)
RESTRICT="test"

DEPEND="
	dev-libs/cxxopts
	dev-cpp/elfio
	dev-cpp/termcolor
	test? ( dev-cpp/gtest )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
