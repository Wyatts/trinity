# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="KControl module for the X11 to configure and switch keyboard layouts"
KEYWORDS=
IUSE=""

DEPEND="x11-libs/libXtst"
RDEPEND="${DEPEND}
	x11-misc/xkeyboard-config
	x11-apps/setxkbmap"

src_configure() {
	mycmakeargs=(
		-DWITH_XTEST=ON
	)

	trinity-meta_src_configure
}
