# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/thesamesam/sam-gentoo-scripts"
inherit git-r3

DESCRIPTION="A collection of scripts for Gentoo development"
HOMEPAGE="https://github.com/thesamesam/sam-gentoo-scripts"

LICENSE="GPL-2"
SLOT="0"

src_install() {
	default

	local dir
	for dir in git keywords maint qa ; do
		exeinto /opt/sam-gentoo-scripts/${dir}
		doexe ${dir}/*
	done
}
