# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ port of Python's glob module"
HOMEPAGE="https://github.com/Kogia-sima/cppglob"
SRC_URI="https://github.com/Kogia-sima/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/gtest )"

PATCHES=(
	"${FILESDIR}/cppglob-1.1.0-cmake.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TEST="$(usex test)"
	)

	cmake_src_configure
}
