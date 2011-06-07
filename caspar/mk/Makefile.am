## Process this file with automake to produce Makefile.in
## This file is maintained at http://git.mdcc.cx/caspar

PACKAGE = @PACKAGE_TARNAME@

mkdir = $(datadir)/$(PACKAGE)/mk
mk_DATA = caspar.mk docbook.mk pod.mk
EXTRA_DIST = caspar.mk docbook.mk pod.mk

install-data-hook:
	$(mkdir_p) $(DESTDIR)$(includedir)/$(PACKAGE)/mk
	for f in $(mk_DATA); do \
          $(LN_S) $(mkdir)/$$f $(DESTDIR)$(includedir)/$(PACKAGE)/mk/$$f; \
        done

uninstall-hook:
	for f in $(mk_DATA); do \
          rm $(DESTDIR)$(includedir)/$(PACKAGE)/mk/$$f; \
        done

