## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.7 2003-08-02 22:06:58 joostvb Exp $

PACKAGE = @PACKAGE_TARNAME@

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk docbook.mk pod.mk
EXTRA_DIST = caspar.mk docbook.mk pod.mk

install-data-hook:
	mkdir -p $(includedir)/$(PACKAGE)/mk
	ln -s $(mkdir)/caspar.mk $(includedir)/$(PACKAGE)/mk/caspar.mk
	ln -s $(mkdir)/docbook.mk $(includedir)/$(PACKAGE)/mk/docbook.mk
	ln -s $(mkdir)/pod.mk $(includedir)/$(PACKAGE)/mk/pod.mk

uninstall-hook:
	rm $(includedir)/$(PACKAGE)/mk/caspar.mk
	rm $(includedir)/$(PACKAGE)/mk/docbook.mk
	rm $(includedir)/$(PACKAGE)/mk/pod.mk

