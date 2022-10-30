# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils toolchain-funcs xdg

MY_P="${P^}"
DESCRIPTION="File encryption tool for GNU/Linux"
HOMEPAGE="https://www.dyne.org/software/tomb https://github.com/dyne/Tomb"
SRC_URI="https://files.dyne.org/tomb/releases/Tomb-${PV}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3 gui? ( GPL-3+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui test tray"

# Test require sudo, can't be done non interactively
RESTRICT="test"

DOCS=(
	AUTHORS.txt
	ChangeLog.txt
	KNOWN_BUGS.txt
	README.txt
	doc/bertini_thesis.pdf
	doc/HACKING.txt
	doc/KEY_SPECIFICATIONS.txt
	doc/LinuxHDEncSettings.txt
	doc/Luks_on_disk_format.pdf
	doc/New_methods_in_HD_encryption.pdf
	doc/TKS1-draft.pdf
	doc/tomb_manpage.pdf
)

DEPEND="
	dev-libs/libgcrypt
	tray? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"
RDEPEND="
	${DEPEND}
	app-admin/sudo
	app-crypt/gnupg
	app-crypt/pinentry
	app-shells/zsh
	sys-fs/cryptsetup
	gui? ( gnome-extra/zenity )
"
BDEPEND="
	dev-python/markdown
	dev-python/pygments
	sys-devel/gettext
"

PATCHES=(
	"${FILESDIR}/${P}-gtomb.patch"
	"${FILESDIR}/${P}-respect-ldflags.patch"
)

src_compile() {
	export CC=$(tc-getCC)
	export PREFIX="${EPREFIX}/usr"
	emake

	emake -C extras/kdf-keys all

	if use tray ; then
		pushd extras/qt-tray || die
		eqmake5
		emake all
		popd || die
	fi

	emake -C extras/translations all
	emake -C doc/literate
}

src_test() {
	emake test
	emake -C extras/kdf-keys test
}

src_install() {
	default

	export PREFIX="${ED}/usr"

	emake -C extras/translations install

	# zenity gui
	if use gui ; then
		pushd extras/gtomb || die
		dobin gtomb
		newdoc README.md README-gtomb
		popd || die
	fi

	# qt tray
	if use tray ; then
		pushd extras/qt-tray || die
		dobin tomb-qt-tray
		doicon pixmaps/tomb_icon.png
		insinto /usr/share
		doins -r i18n
		popd || die
	fi

	# kdf programs
	emake -C extras/kdf-keys install

	# TODO: Is there an eclass for this?
	# pixmap
	pushd extras/gtk-tray || die
	doicon monmort.xpm
	newicon --context mimetypes --size 32 monmort.xpm monmort
	newicon --size 32 monmort.xpm dyne-monmort
	popd || die

	pushd extras/desktop || die
	# copied from install.zsh
	# mime types
	insinto /usr/share/mime/packages
	doins dyne-tomb.xml
	# desktop
	domenu tomb.desktop
	# menu
	insinto /etc/menu
	doins tomb
	# mime info
	insinto /usr/share/mime-info
	doins tomb.mime
	doins tomb.keys
	insinto /usr/lib/mime/packages
	newins tomb.mimepkg tomb
	# application entry
	insinto /usr/share/application-registry
	doins tomb.applications
	popd || die

	einstalldocs

	cd doc/literate || die
	docinto html
	dodoc -r *.html *.css public
}
