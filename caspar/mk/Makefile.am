## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.2 2002-02-26 19:13:14 joostvb Exp $

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = install.mk
EXTRA_DIST = install.mk

install-data-hook:
	mkdir -p $(includedir)/$(PACKAGE)/mk
	-rm $(includedir)/$(PACKAGE)/mk/install.mk
	ln -s $(mkdir)/install.mk $(includedir)/$(PACKAGE)/mk/install.mk
