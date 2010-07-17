## Process this file with automake to produce Makefile.in
## This file maintained using arch at http://arch.gna.org/uruk/

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
## Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
## Copyright (C) 2003, 2004, 2005 Joost van Baal

## see booststrap for git2cl
ChangeLog: NEWS
	git log --pretty --numstat --summary | sed 's/<[^>][^>]*>//g' | git2cl >ChangeLog

VERSION.m4 VERSION stamp.year stamp.month stamp.day: ChangeLog
	./setversion

CONFIGURE_DEPENDENCIES = VERSION.m4

## used in make dist[check]
VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

SUBDIRS = script man doc contrib init

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog ChangeLog.2003 README THANKS TODO

EXTRA_DIST = bootstrap ChangeLog.2003 setversion stamp.month stamp.year \
  stamp.day VERSION.m4 VERSION

