## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.5 2002-03-13 12:11:17 joostvb Exp $

VERSION: ChangeLog
	./setversion

VERSION = @VERSION@

SUBDIRS = mk sgml

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO

## Only files from the current directory or from subdirectory which
## don't have their own Makefile.am should be listed here.
EXTRA_DIST = \
   VERSION

