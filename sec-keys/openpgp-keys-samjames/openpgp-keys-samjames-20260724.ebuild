# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	'5EF3A41171BB77E6110ED2D01F3D03348DB1A3E2:sam:gentoo'
)

inherit sec-keys

DESCRIPTION="OpenPGP keys used by Sam James"
HOMEPAGE="https://wiki.gentoo.org/wiki/User:Sam"

KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ppc ppc64 ~riscv ~s390 ~sparc x86"
