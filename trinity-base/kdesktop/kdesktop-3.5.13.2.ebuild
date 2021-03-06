# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="The part of TDE ui that handles icons, desktop, screensaver etc"
KEYWORDS="~amd64 ~x86"
IUSE="pam xscreensaver"

DEPEND="x11-libs/libXrender
	x11-libs/libXcursor
	>=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kcontrol-${PV}:${SLOT}
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	>=trinity-base/kcheckpass-${PV}:${SLOT}
	>=trinity-base/kdialog-${PV}:${SLOT}
	>=trinity-base/konqueror-${PV}:${SLOT}
	xscreensaver? ( x11-libs/libXScrnSaver )
	pam? ( trinity-base/tdebase-pam )"

TSM_EXTRACT_ALSO="kcheckpass/"

PATCHES=( "$FILESDIR/${PN}-3.5.13.1-onlyshowin-tde.patch")

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSORS=ON
		-DWITH_XRENDER=ON
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-meta_src_configure
}

src_install() {
	trinity-meta_src_install
	trinity-base_fix_desktop_files "${D}${TDEDIR}/share/apps/kdesktop/Desktop/"*
}
