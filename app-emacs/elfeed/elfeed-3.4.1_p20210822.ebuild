# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SITEFILE="50${PN}-gentoo.el"
inherit elisp

DESCRIPTION="Emacs web feeds client"
HOMEPAGE="https://github.com/skeeto/elfeed"
if [[ ${PV} == *_p* ]] ; then
	MY_COMMIT="162d7d545ed41c27967d108c04aa31f5a61c8e16"
	SRC_URI="https://github.com/skeeto/elfeed/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${MY_COMMIT}
else
	SRC_URI="https://github.com/skeeto/elfeed/releases/download/${PV}/${P}.tar"
fi

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

# Upstream prefer curl, but if you can't have that,
# use Emacs with gnutls support.
# https://github.com/skeeto/elfeed#prerequisites
# https://github.com/skeeto/elfeed#platform-support
RDEPEND="
	|| (
	   net-misc/curl
	   app-editors/emacs[ssl(-)]
	)
"
