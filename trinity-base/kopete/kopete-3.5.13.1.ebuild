# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity multi-protocol IM client"
KEYWORDS="amd64 x86"

IUSE="jingle gsmlib netmeeting speex kernel_linux"
PLUGINS="latex autoreplace history contactnotes crypt connectionstatus
	translator nowlistening webpresence texteffect highlight alias
	motionautoaway netmeeting addbookmarks statistics smpppdcs"
PROTOCOLS="gadu groupwise irc xmpp oscar msn sms sametime winpopup yahoo"
# unsupported USE="v4l2 opengl xscreensaver ssl emoticons-manager "
# USE=xmms works only with xmms1
IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"
REQUIRED_USE="
	jingle? ( xmpp )
	gsmlib? ( sms )
	netmeeting? ( msn )
	speex? ( jingle xmpp )"

# MISSING BOTH_DEPEND
#	x11-libs/libXrender
#	xmpp? ( net-dns/libidn )
#	kernel_linux? ( virtual/opengl )
#	opengl? ( dev-qt/qt-meta[opengl] )
#	xscreensaver? ( x11-libs/libXScrnSaver )
#	xmpp|groupwice? =app-crypt/qca-1.0*
BOTH_DEPEND="
	jingle? ( dev-libs/glib:2 )
	netmeeting? ( dev-libs/glib:2 )
	webpresence? (
		dev-libs/libxml2
		dev-libs/libxslt )
	jingle? (
		dev-libs/expat
		speex? ( >=media-libs/speex-1.1.6 )
	)
	gsmlib? ( app-mobilephone/gsmlib )
	gadu? ( net-libs/libgadu )
	sametime? ( net-libs/meanwhile )
	media-libs/libv4l
"

# MISSING DEPEND
#	x11-proto/videoproto
#	kernel_linux? (
#		x11-libs/libXv
#	)
#	xscreensaver? ( x11-proto/scrnsaverproto )
DEPEND="${BOTH_DEPEND}
	kernel_linux? (
		virtual/os-headers
	)
"

# MISSING RDEPEND
#     netmeeting? ( net-voip/ekiga )
#     ssl? ( =app-crypt/qca-tls-1.0* )
RDEPEND="${BOTH_DEPEND}
	crypt? ( app-crypt/gnupg )
	latex? (
		media-gfx/imagemagick
		virtual/latex-base )
	sms? ( !gsmlib? ( || (
				app-mobilephone/smsclient
				app-mobilephone/smssend	) ) )
"

PATCHES=( "${FILESDIR}/${P}-patches" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with jingle      JINGLE)
		$(cmake-utils_use_with gsmlib      GSM)
		$(cmake-utils_use_with netmeeting  WEBCAM)
		$(cmake-utils_use_with speex       SPEEX)

		$(cmake-utils_use_build latex            KOPETE_PLUGIN_LATEX)
		$(cmake-utils_use_build autoreplace      KOPETE_PLUGIN_AUTOREPLACE)
		$(cmake-utils_use_build history          KOPETE_PLUGIN_HISTORY)
		$(cmake-utils_use_build contactnotes     KOPETE_PLUGIN_CONTACTNOTES)
		$(cmake-utils_use_build crypt            KOPETE_PLUGIN_CRYPTOGRAPHY)
		$(cmake-utils_use_build connectionstatus KOPETE_PLUGIN_CONNECTIONSTATUS)
		$(cmake-utils_use_build translator       KOPETE_PLUGIN_TRANSLATOR)
		$(cmake-utils_use_build nowlistening     KOPETE_PLUGIN_NOWLISTENING)
		$(cmake-utils_use_build webpresence      KOPETE_PLUGIN_WEBPRESENCE)
		$(cmake-utils_use_build texteffect       KOPETE_PLUGIN_TEXTEFFECT)
		$(cmake-utils_use_build highlight        KOPETE_PLUGIN_HIGHLIGHT)
		$(cmake-utils_use_build alias            KOPETE_PLUGIN_ALIAS)
		$(cmake-utils_use_build motionautoaway   KOPETE_PLUGIN_MOTIONAUTOAWAY)
		$(cmake-utils_use_build netmeeting       KOPETE_PLUGIN_NETMEETING)
		$(cmake-utils_use_build addbookmarks     KOPETE_PLUGIN_ADDBOOKMARKS)
		$(cmake-utils_use_build statistics       KOPETE_PLUGIN_STATISTICS)
		$(cmake-utils_use_build smpppdcs         KOPETE_PLUGIN_SMPPPDCS)

		$(cmake-utils_use_build gadu      KOPETE_PROTOCOL_GADU)
		$(cmake-utils_use_build groupwise KOPETE_PROTOCOL_GROUPWISE)
		$(cmake-utils_use_build irc       KOPETE_PROTOCOL_IRC)
		$(cmake-utils_use_build xmpp      KOPETE_PROTOCOL_JABBER)
		$(cmake-utils_use_build oscar     KOPETE_PROTOCOL_OSCAR)
		$(cmake-utils_use_build msn       KOPETE_PROTOCOL_MSN)
		$(cmake-utils_use_build sms       KOPETE_PROTOCOL_SMS)
		$(cmake-utils_use_build sametime  KOPETE_PROTOCOL_MEANWHILE)
		$(cmake-utils_use_build winpopup  KOPETE_PROTOCOL_WINPOPUP)
		$(cmake-utils_use_build yahoo     KOPETE_PROTOCOL_YAHOO)
	)

	trinity-meta_src_configure
}
