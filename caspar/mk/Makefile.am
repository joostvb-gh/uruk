## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.9 2004-07-21 15:34:02 joostvb Exp $

PACKAGE = @PACKAGE_TARNAME@

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk docbook.mk pod.mk
EXTRA_DIST = caspar.mk docbook.mk pod.mk

install-data-hook:
	$(mkdir_p) $(DESTDIR)$(includedir)/$(PACKAGE)/mk
	$(LN_S) $(mkdir)/caspar.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/caspar.mk
	$(LN_S) $(mkdir)/docbook.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/docbook.mk
	$(LN_S) $(mkdir)/pod.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/pod.mk

uninstall-hook:
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/caspar.mk
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/docbook.mk
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/pod.mk

