# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="B2 Python SDK"
HOMEPAGE="
	https://github.com/Backblaze/b2-sdk-python
	https://pypi.org/project/b2sdk/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/logfury[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

# TODO
#distutils_enable_tests pytest
