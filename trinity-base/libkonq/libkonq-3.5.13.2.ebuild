# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~x86"
IUSE="arts"
DEPEND="arts? ( >=trinity-base/arts-${PV}:${SLOT} )"
RDEPEND="$DEPEND"
PATCHES=( "$FILESDIR/${PN}-3.5.13.1-onlyshowin-tde.patch")

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
