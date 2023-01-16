# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python bindings for pkgcraft"
HOMEPAGE="
	https://pypi.org/project/pkgcraft/
	https://github.com/pkgcraft/pkgcraft-python
"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcraft/pkgcraft-python"
	inherit git-r3
else
	SRC_URI="https://github.com/pkgcraft/pkgcraft-python/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-1"
SLOT="0"
IUSE="+examples"

RDEPEND="sys-libs/pkgcraft:="
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/cython
	dev-python/setuptools_scm
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

python_install() {
	# Conditional because these aren't installed officially right now
	# and the naming is just for convenience.
	if use examples ; then
		set -x
		while IFS= read -r -d '' file ; do
			python_newexe "${S}"/examples/${file##*/} pkgcraft-${file##*/}
		done < <(find "${S}"/examples -type f -executable -print0 || die)
		set +x
	fi

	distutils-r1_python_install
}
