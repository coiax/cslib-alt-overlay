# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit bzr python distutils

DESCRIPTION="Python bindings for the bullet library"
HOMEPAGE="https://launchpad.net/pybullet"
SRC_URI=""
EBZR_REPO_URI="lp:pybullet"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64-linux"
IUSE=""

DEPEND="sci-physics/bullet
dev-python/numpy
dev-python/cython"
RDEPEND="${DEPEND}"

