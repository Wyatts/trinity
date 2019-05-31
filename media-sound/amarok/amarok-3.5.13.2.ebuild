# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI="5"
TRINITY_MODULE_TYPE="applications"
TRINITY_MODULE_VER="3.5.13.2"

ARTS_REQUIRED="never"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="af ar az be bg bn br ca cs cy da de el en_GB eo es et eu fa fi
fr ga gl he hi hu id is it ja ka km ko ku lo lt mk ms nb nds ne nl nn pa
pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn ss sv ta tg th tr uk uz uz@cyrillic
zh_CN zh_TW"

TRINITY_DOC_LANGS="da de es et fr it nl pl pt pt_BR ru sv"

inherit trinity-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"

need-trinity 3.5.13

SLOT="${TRINITY_VER}"
# Notes on flags:
# - This version supports three engines: xine, yauap, and akode.  The only one
#   in the tree at the moment is xine. Akode is still maintained by trinity, so
#   it's a possibility, but yauap seems pretty dead.
# - After several years of the mysql hegemony in Amarok 2.x, the KF5 port is
#   apparently moving back to sqlite exclusively.  Trinity Amarok beat them to
#   the punch by about a decade.
# - This version supports Rio Karma but there's no lib for it in the tree?
# - The daap flag depended on mongrel in old amarok.  Mongrel 2 is keyworded
#   and it's not clear if any external deps are even needed.  Certainly doesn't
#   seem to configure properly!
# - amazon isn't a flag anymore.  Is it even in there anymore?  The code is...
# - musicbrainz relied on the old tunepimp lib and it's not an option in their
#   CMakeLists.txt. I'm pretty sure it's ALL changed at this point anyway.
#   Will look into libmusicbrainz later.
# - Can't see any way to enable/disable opengl in the CMake system
# - Didn't see any options for Python.  Unsupported?
# - UNTESTED FLAGS: ifp njb ipod mtp
#option( WITH_LIBVISUAL "Enable libvisual support" OFF )

IUSE="kde +xine ipod ifp njb mtp mp4 inotify"

#visualization  
#python"

DEPEND="
	!<media-sound/amarok-1.4.10_p20090130-r2
	>=dev-lang/ruby-1.8
	>=media-libs/taglib-1.4
	>=media-libs/xine-lib-1.1.2_pre20060328-r8
	mp4? ( media-libs/libmp4v2 )
	ipod? ( >=media-libs/libgpod-0.5.2 )
	ifp? ( media-libs/libifp )
	njb? ( >=media-libs/libnjb-2.2.4 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
"
	#daap? ( www-servers/mongrel )
	#musicbrainz? ( media-libs/tunepimp )
	#opengl? ( virtual/opengl )
	#visualization? (
		#media-libs/libsdl
		#=media-plugins/libvisual-plugins-0.4*
	#)

	#postgres? ( dev-db/postgresql )
	#mysql? ( >=virtual/mysql-4.0 )

RDEPEND="${DEPEND}
	app-arch/unzip
"
	#python? ( dev-python/PyQt )

PATCHES=(
	"${FILESDIR}/${PN}-${TRINITY_MODULE_VER}-gcc6-fix.patch"
	)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kde KONQSIDEBAR)
		$(cmake-utils_use_with xine XINE)
		$(cmake-utils_use_with ipod IPOD)
		$(cmake-utils_use_with ifp IFP)
		$(cmake-utils_use_with njb NJB)
		$(cmake-utils_use_with mtp MTP)
		$(cmake-utils_use_with mp4 MP4V2)
		$(cmake-utils_use_with inotify INOTIFY)
	)

	trinity-base_src_configure
}
