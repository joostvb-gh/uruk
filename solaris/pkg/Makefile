# $Id: Makefile,v 1.1 2005-03-02 19:58:32 joostvb Exp $
# $Source: /cvsroot/caspar/caspar/solaris/pkg/Attic/Makefile,v $

# solaris/Makefile - enable solaris package building from within
#    patched upstream tarball

# Idea based upon debian .deb source package format,
# See appendix C. ``Source packages'' from ``Debian Policy Manual'',
# http://packages.debian.org/debian-policy ; 
# http://www.debian.org/doc/debian-policy/ap-pkg-sourcepkg.html

# This Makefile based upon the one shipped with
# http://non-gnu.uvt.nl/pub/nagios-plugins/solaris/src/nagios-plugins-1.3.1_3.diff.gz

# Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
# Copyright (C) 2005 Joost van Baal
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# A copy of the GNU General Public License is available online at
# http://www.gnu.org/copyleft/gpl.html, or write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111,
# USA.

# see also
# http://www.bolthole.com/solaris/makeapackage.html

VENDORTAG = UVT

TARNAME = caspar
UPVERSION = 20050302
VERSION = $(UPVERSION)_1
SHORTTARNAME = caspar  # max 6 chars: some old solaris-en break otherwise

# call make as e.g.
#
# make -e -f solaris/Makefile OSVERSION=sol7
#
# to overrule this default
OSVERSION = sol8
ARCH = sparc
EXT = local
SRCPKGFILENAME = $(TARNAME)-$(VERSION)
PKGFILENAME = $(SRCPKGFILENAME)-$(OSVERSION)-$(ARCH)-$(EXT)
PKGNAME = $(VENDORTAG)$(SHORTTARNAME)

INSTALLROOT = `pwd`/install

# should be absolute path
PKGROOT = /var/tmp

all: binary-stamp

configure-stamp:
	./configure
	touch configure-stamp

build-stamp: configure-stamp
	make
	touch build-stamp

install-stamp: build-stamp native-install-stamp solaris-install-stamp
	touch install-stamp

native-install-stamp: build-stamp
	# solaris make needs -e for overwriting macros
	make -e install DESTDIR=$(INSTALLROOT)
##	mkdir -p $(INSTALLROOT)/usr/local/share/doc/$(TARNAME)/examples
##	cp AUTHORS COPYING ChangeLog FAQ LEGAL NEWS README SUPPORT $(INSTALLROOT)/usr/local/share/doc/$(TARNAME)
	touch native-install-stamp

version-stamp:
	sed 's/@VERSION@/$(VERSION)/' < solaris/pkginfo.in > solaris/pkginfo
	touch version-stamp

solaris-install-stamp: build-stamp version-stamp
	mkdir -p $(INSTALLROOT)/usr/local/share/doc/$(TARNAME)
	cp solaris/README.Solaris $(INSTALLROOT)/usr/local/share/doc/$(TARNAME)
	touch solaris-install-stamp

# we dynamically generate the prototype file
# FIXME is this sane?  See http://non-gnu.uvt.nl/pub/nrpe/solaris/src/ for an alternative
# way to deal with this.
pkgproto-stamp: install-stamp
	(cd $(INSTALLROOT); find usr/local/lib/nagios/plugins -type f | while read f; do echo f none $$f; done) > prototype.inc
	mv prototype.inc $(INSTALLROOT)
	cp solaris/prototype solaris/pkginfo $(INSTALLROOT)
	touch pkgproto-stamp

pkgmk-stamp: pkgproto-stamp
	cd $(INSTALLROOT); pkgmk -o -d $(PKGROOT) -r `pwd`
	touch pkgmk-stamp

# if we maintain pkgproto ourselfs manually, replace with:
# pkgmk-stamp: install-stamp

pkgtrans-stamp: pkgmk-stamp
	cd $(PKGROOT); pkgtrans -s `pwd` $(PKGFILENAME) $(PKGNAME)
	touch pkgtrans-stamp

zip-stamp: pkgtrans-stamp
	cd $(PKGROOT); gzip -c $(PKGFILENAME) > $(PKGFILENAME).gz
	touch zip-stamp

binary-stamp: zip-stamp
	@ls -l $(PKGROOT)/$(PKGFILENAME)
	@ls -l $(PKGROOT)/$(PKGFILENAME).gz
	touch binary-stamp

clean-stamp: solaris-clean-stamp
	touch clean-stamp

clean: clean-stamp

solaris-clean-stamp:
	rm -r $(INSTALLROOT)
	touch solaris-clean-stamp

source-stamp:
	@echo make sure ../$(TARNAME)-$(UPVERSION).orig and ../$(TARNAME)-$(UPVERSION) are clean!
	cd ..; diff -Pdur $(TARNAME)-$(UPVERSION).orig $(TARNAME)-$(UPVERSION) | gzip -c > $(SRCPKGFILENAME).diff.gz
	@ls -l ../$(SRCPKGFILENAME).diff.gz
	touch source-stamp

