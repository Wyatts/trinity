# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="KControl module for the X11 keyboard extension to configure and switch between keyboard mappings."
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/libXtst"
RDEPEND="x11-libs/libXtst
	x11-misc/xkeyboard-config
	x11-apps/setxkbmap"
