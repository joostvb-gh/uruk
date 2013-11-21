## Process this file with automake to produce Makefile.in
## This file is maintained at http://git.mdcc.cx/caspar

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003, 2004, 2005, 2006 Joost van Baal
## based upon work by Stijn van Dongen

TROFF = groff

## Zoem is a an interpretive macro language, for creating mark-up languages, by
## Stijn van Dongen. Information about zoem can be found on the zoem webpage at
## http://micans.org/zoem/ .
ZOEM = zoem

## tidy is a HTML syntax checker and reformatter, available from
## http://www.w3.org/People/Raggett/tidy/ , by Dave Raggett <dsr@w3.org>

# FIXME likely it's better NOT to ignore errors from tidy.  if you do, building on a
# host which lacks tidy will fail terribly _and_ silently!  Or: test here if tidy
# is installed...
TIDY = tidy -quiet -utf8

## http://w3m.sourceforge.net/
## w3m is a text-based web browser, which can be used as a text formatting tool
## which typesets HTML into plain text.
W3M = w3m

PACKAGE = @PACKAGE_TARNAME@
docdir = $(datadir)/doc/$(PACKAGE)

azms = casparize.azm csp_helper.azm caspar.azm caspar-typesetting.azm
typetargets = casparize.html casparize.ps casparize.txt csp_helper.html \
  csp_helper.ps csp_helper.txt caspar.html caspar.ps \
  caspar.txt caspar-typesetting.html caspar-typesetting.ps \
  caspar-typesetting.txt
man1s = csp_install.1 csp_mkdircp.1 csp_scp_keep_mode.1 csp_sucp.1
manazms = casparize.1 csp_helper.1 caspar.7 caspar-typesetting.7
tmpfiles = casparize.zmr casparize.zmt caspar-typesetting.zmr \
  caspar-typesetting.zmt caspar.zmr caspar.zmt csp_helper.zmr csp_helper.zmt


doc_DATA = $(typetargets) $(azms) ChangeLog.2002
man_MANS = $(man1s) $(manazms)

EXTRA_DIST = $(doc_DATA) $(man_MANS)

SUFFIXES = .1 .7 .azm .html .ps .txt

.azm.1:
	$(ZOEM) -d roff -i $< -o $@
	$(ZOEM) -d roff -i $< -o $@

.azm.7:
	$(ZOEM) -d roff -i $< -o $@
	$(ZOEM) -d roff -i $< -o $@

.7.ps:
	$(TROFF) -man $< > $@

.1.ps:
	$(TROFF) -man $< > $@

.azm.html:
	$(ZOEM) -d html -i $< -o $@
	$(ZOEM) -d html -i $< -o $@
	-$(TIDY) -e $@

## alternative, one could call something like
## groff -man -Tascii $< > $@
## for generating ascii directly from roff.
## However, this generates output which uses the boldface-^H trick
.html.txt:
	$(W3M) -dump $< > $@

MAINTAINERCLEANFILES = $(manazms) $(typetargets) $(tmpfiles)

DISTCLEANFILES = $(typetargets)
