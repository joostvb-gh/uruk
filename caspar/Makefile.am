## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.6 2003-08-02 21:41:12 joostvb Exp $

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Joost van Baal

VERSION.m4: ChangeLog
	./setversion

CONFIGURE_DEPENDENCIES = VERSION.m4

## used in make dist[check]
VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

SUBDIRS = mk sgml

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO

## Only files from the current directory or from subdirectory which
## don't have their own Makefile.am should be listed here.
EXTRA_DIST = bootstrap setversion VERSION.m4

