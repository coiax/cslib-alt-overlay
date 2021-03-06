# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-mga/xf86-video-mga-1.4.13.ebuild,v 1.6 2011/02/14 23:56:22 xarthisius Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="Matrox video driver"

SLOT="0"
KEYWORDS="~amd64-linux"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.4"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			x11-proto/glproto
			>=x11-libs/libdrm-2 )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
