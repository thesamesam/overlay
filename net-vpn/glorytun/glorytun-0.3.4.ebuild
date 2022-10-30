# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Create tunnels over TCP/IP networks with shaping, encryption, and compression"
HOMEPAGE="https://github.com/angt/glorytun"
SRC_URI="https://github.com/angt/glorytun/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-libs/libsodium-1.0.4:="
DEPEND="${RDEPEND}"
