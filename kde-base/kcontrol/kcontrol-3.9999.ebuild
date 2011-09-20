# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME=kdebase
EAPI="2"
inherit trinity-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS=""
IUSE="samba logitech-mouse ieee1394"

SLOT="3.5"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXcursor
	x11-libs/libXrandr
	dev-libs/openssl
	samba? ( net-fs/samba )
	logitech-mouse? ( virtual/libusb:0 )
	ieee1394? ( sys-libs/libraw1394 )
	kde-base/kdelibs:${SLOT}
	>=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kicker-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/kdesu-${PV}:${SLOT}
	>=kde-base/khelpcenter-${PV}:${SLOT}
	>=kde-base/khotkeys-${PV}:${SLOT}"

# possible dependecies
# DEPEND="
#	>=media-libs/freetype-2.3
#	media-libs/fontconfig"
# RDEPEND="${DEPEND}

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSOR=ON
		-DWITH_XRANDR=ON
		-DWITH_USBIDS=/usr/share/misc/usb.ids
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with logitech-mouse LIBUSB)
		$(cmake-utils_use_with ieee1394 LIBRAW1394)
	)

	trinity-meta_src_configure
}