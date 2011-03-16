# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games git

DESCRIPTION="Minecraft map renderer"
HOMEPAGE="https://github.com/udoprog/c10t/"
#SRC_URI="https://github.com/udoprog/c10t.git"

EGIT_REPO_URI="https://github.com/udoprog/c10t.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-linux"
IUSE=""

DEPEND="media-libs/libpng
	media-libs/freetype
	dev-libs/boost
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_configure() {
	mkdir build
	cd build
	cmake .. || die
}

src_compile() {
	cd build
	emake || die
}

src_install() {
	cd build
	dobin c10t
}
