## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.2 2002-02-26 17:54:28 joostvb Exp $

VERSION: ChangeLog
	./setversion

VERSION = @VERSION@

SUBDIRS = mk

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO

## Only files from the current directory or from subdirectory which
## don't have their own Makefile.am should be listed here.
EXTRA_DIST = \
   BUGS
   VERSION

