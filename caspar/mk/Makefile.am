## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.4 2002-03-01 15:15:06 joostvb Exp $

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk docbook.mk
EXTRA_DIST = caspar.mk docbook.mk

install-data-hook:
	mkdir -p $(includedir)/$(PACKAGE)/mk
	-rm $(includedir)/$(PACKAGE)/mk/caspar.mk
	-rm $(includedir)/$(PACKAGE)/mk/docbook.mk
	ln -s $(mkdir)/caspar.mk $(includedir)/$(PACKAGE)/mk/caspar.mk
	ln -s $(mkdir)/docbook.mk $(includedir)/$(PACKAGE)/mk/docbook.mk
