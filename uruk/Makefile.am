## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.10 2004/02/10 17:08:38 joostvb Exp $

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
## Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
## Copyright (C) 2003, 2004 Joost van Baal

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

SUBDIRS = script man doc init

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO

EXTRA_DIST = bootstrap setversion VERSION.m4 VERSION \
  stamp.month stamp.year stamp.day

