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
IUSE="mp4"
#IUSE="mp4 mysql +amazon opengl postgres
#visualization ipod ifp real njb mtp musicbrainz daap
#python"
# kde: enables compilation of the konqueror sidebar plugin

DEPEND="
	!<media-sound/amarok-1.4.10_p20090130-r2
	>=dev-lang/ruby-1.8
	>=media-libs/taglib-1.4
	mp4? ( media-libs/libmp4v2 )
"
	#>=media-libs/xine-lib-1.1.2_pre20060328-r8
	#ifp? ( media-libs/libifp )
	#ipod? ( >=media-libs/libgpod-0.5.2 )
	#mp4? ( media-libs/libmp4v2 )
	#mtp? ( >=media-libs/libmtp-0.3.0 )
	#musicbrainz? ( media-libs/tunepimp )
	#mysql? ( >=virtual/mysql-4.0 )
	#njb? ( >=media-libs/libnjb-2.2.4 )
	#opengl? ( virtual/opengl )
	#postgres? ( dev-db/postgresql-base )
	#real? (
		#media-libs/alsa-lib
		#media-video/realplayer
	#)
	#visualization? (
		#media-libs/libsdl
		#=media-plugins/libvisual-plugins-0.4*
	#)
#"

RDEPEND="${DEPEND}
	app-arch/unzip
"
	#daap? ( www-servers/mongrel )
	#python? ( dev-python/PyQt )

PATCHES=(
	"${FILESDIR}/${PN}-${TRINITY_MODULE_VER}-gcc6-fix.patch"
	)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with mp4 MP4V2)
	)

	trinity-base_src_configure
}
