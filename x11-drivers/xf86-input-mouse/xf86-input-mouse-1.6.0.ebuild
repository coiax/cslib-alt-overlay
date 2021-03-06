# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-mouse/xf86-input-mouse-1.6.0.ebuild,v 1.8 2011/02/14 23:56:24 xarthisius Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org driver for mouse input devices"

KEYWORDS="~amd64-linux"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5.99.901"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
