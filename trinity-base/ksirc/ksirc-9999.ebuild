# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity irc client"
KEYWORDS=
IUSE="ssl"

RDEPEND="dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL )"
