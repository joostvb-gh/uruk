## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.3 2002-02-27 16:53:27 joostvb Exp $

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk
EXTRA_DIST = caspar.mk

install-data-hook:
	mkdir -p $(includedir)/$(PACKAGE)/mk
	-rm $(includedir)/$(PACKAGE)/mk/caspar.mk
	ln -s $(mkdir)/caspar.mk $(includedir)/$(PACKAGE)/mk/caspar.mk
