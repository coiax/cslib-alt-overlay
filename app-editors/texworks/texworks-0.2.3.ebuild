# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4-r2

DESCRIPTION="simple TeX front-end program"
HOMEPAGE="http://www.tug.org/texworks/"
SRC_URI="http://texworks.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64-linux"
IUSE=""

DEPEND=">=app-text/poppler-0.12[qt4]
	>=app-text/hunspell-1.2.8
	sys-apps/dbus
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-dbus:4"
RDEPEND="${DEPEND}"

src_install() {
	dobin texworks || die
}
