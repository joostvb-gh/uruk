## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.1 2002-02-26 17:52:17 joostvb Exp $

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = install.mk
EXTRA_DIST = install.mk

install-data-hook:
	mkdir -p $(includedir)/$(PACKAGE)/mk
	ln -s $(mkdir)/install.mk $(includedir)/$(PACKAGE)/mk/install.mk
