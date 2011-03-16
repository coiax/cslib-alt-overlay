# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.6.0.ebuild,v 1.4 2011/02/14 23:56:23 xarthisius Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="Generic Linux input driver"
KEYWORDS="~amd64-linux"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6.3"
DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-2.6
	x11-proto/inputproto
	x11-proto/xproto"
