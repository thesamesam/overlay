# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

MY_COMMIT="e8ad266af883b60e88012957e89bf361924ea5ec"
DESCRIPTION="rtl88x2bu driver updated for current kernels"
HOMEPAGE="https://github.com/cilynx/rtl88x2bu"
SRC_URI="https://github.com/cilynx/rtl88x2bu/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN/realtek-/}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dist-kernel"

RDEPEND="dist-kernel? ( virtual/dist-kernel:= )"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! use kernel_linux ; then
		die "Unable to install"
	fi

	BUILD_TARGETS="clean modules"
	MODULE_NAMES="88x2bu(misc:)"
	BUILD_PARAMS="KV=${KV_FULL} KSRC=${KERNEL_DIR}"

	linux-mod_pkg_setup
}
