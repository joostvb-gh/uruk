## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.8 2004-07-21 14:21:43 joostvb Exp $

PACKAGE = @PACKAGE_TARNAME@

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk docbook.mk pod.mk
EXTRA_DIST = caspar.mk docbook.mk pod.mk

install-data-hook:
	$(mkdir_p) $(DESTDIR)$(includedir)/$(PACKAGE)/mk
	$(LN_S) $(DESTDIR)$(mkdir)/caspar.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/caspar.mk
	$(LN_S) $(DESTDIR)$(mkdir)/docbook.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/docbook.mk
	$(LN_S) $(DESTDIR)$(mkdir)/pod.mk $(DESTDIR)$(includedir)/$(PACKAGE)/mk/pod.mk

# 	$(LN_S) $(mkdir)/pod.mk $(includedir)/$(PACKAGE)/mk/pod.mk

uninstall-hook:
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/caspar.mk
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/docbook.mk
	rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/pod.mk

