# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdeartwork"

inherit trinity-meta

DESCRIPTION="Extra screensavers for Trinity"
KEYWORDS="x86 amd64"
IUSE="opengl xscreensaver arts"

DEPEND="
	>=trinity-base/kscreensaver-${PV}:${SLOT}
	>=trinity-base/krootbacking-${PV}:${SLOT}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )
	arts? ( trinity-base/arts )"
RDEPEND="$DEPEND"

TSM_EXTRACT_ALSO="FindXscreensaver.cmake"

src_configure() {
	mycmakeargs=(
		-DWITH_LIBART=ON
		$(cmake-utils_use_with opengl OPENGL)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
