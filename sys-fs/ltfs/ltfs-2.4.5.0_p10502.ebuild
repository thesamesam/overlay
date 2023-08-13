# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="LTFS for LTO tapes"
HOMEPAGE="https://github.com/LinearTapeFileSystem/ltfs"

inherit autotools

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/LinearTapeFileSystem/ltfs.git"
	inherit git-r3
else
	SRC_URI="https://github.com/LinearTapeFileSystem/ltfs/archive/refs/tags/v${PV%%_p*}-${PV##*_p}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${PV%%_p*}-${PV##*_p}

	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
IUSE="snmp"

RDEPEND="
	>=dev-libs/libxml2-2.6.16
	dev-libs/icu:=
	>=sys-apps/util-linux-1.36
	>=sys-fs/fuse-2.6.0:0
	snmp? ( >=net-analyzer/net-snmp-5.3 )
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/ltfs-2.4.5.0_p10502-drop-deprecated-pthread_yield-glibc-2.34.patch
)

src_prepare(){
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable snmp)
	)

	econf "${myeconfargs[@]}"
}
