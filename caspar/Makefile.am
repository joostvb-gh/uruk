## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.7 2003-08-09 13:41:24 joostvb Exp $

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Joost van Baal

## you need cvs2cl for this to work.  get it from
## http://www.red-bean.com/cvs2cl/ .
ChangeLog: NEWS
	cvs2cl --accum --prune

VERSION.m4 VERSION stamp.year stamp.month stamp.day: ChangeLog
	./setversion

CONFIGURE_DEPENDENCIES = VERSION.m4

## used in make dist[check]
VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

SUBDIRS = doc mk sgml

docdir = $(datadir)/doc/$(PACKAGE_TARNAME)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO NEWS

## Only files from the current directory or from subdirectory which
## don't have their own Makefile.am should be listed here.
EXTRA_DIST = bootstrap setversion VERSION.m4

