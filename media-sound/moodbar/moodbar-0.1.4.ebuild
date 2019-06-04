# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils autotools

DESCRIPTION="The moodbar tool and gstreamer plugin for Amarok"
HOMEPAGE="https://amarok.kde.org/wiki/Moodbar"
#SRC_URI="http://pwsp.net/~qbob/moodbar-${PV}.tar.gz"
SRC_URI="https://github.com/Mazhoon/moodbar/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mp3 ogg vorbis flac"

RDEPEND="media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-plugins/gst-plugins-meta:1.0
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	AT_M4DIR="m4" eautoreconf
	#eautomake
	#epatch "${FILESDIR}"/${P}-gthread_init.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

