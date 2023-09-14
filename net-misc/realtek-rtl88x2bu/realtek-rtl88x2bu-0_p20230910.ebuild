# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_COMMIT="e1e98a4bb11c085b68ce7823d44eee703c7422c9"
DESCRIPTION="rtl88x2bu driver updated for current kernels"
HOMEPAGE="https://github.com/cilynx/rtl88x2bu"
SRC_URI="https://github.com/cilynx/rtl88x2bu/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN/realtek-/}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	local modlist=( 88x2bu )
	local modargs=( KV=${KV_FULL} KSRC=${KERNEL_DIR} )

	linux-mod-r1_src_compile
}
