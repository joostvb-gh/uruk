## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.1 2003-08-09 12:56:48 joostvb Exp $

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Joost van Baal, based upon work by Stijn van Dongen

TROFF = groff

## Zoem is a an interpretive macro language, for creating mark-up languages, by
## Stijn van Dongen. Information about zoem can be found on the zoem webpage at
## http://micans.org/zoem/ .
ZOEM = zoem

## tidy is a HTML syntax checker and reformatter, available from
## http://www.w3.org/People/Raggett/tidy/ , by Dave Raggett <dsr@w3.org>
TIDY = tidy -quiet

docdir = $(datadir)/doc/$(PACKAGE_TARNAME)

azms = caspar.azm
typetargets = caspar.html caspar.ps

doc_DATA = $(typetargets) $(azms)
man_MANS = caspar.7

EXTRA_DIST = $(doc_DATA) $(man_MANS)

SUFFIXES = .7 .azm .html .ps

.azm.7:
	$(ZOEM) -d roff -i $< -o $@
	$(ZOEM) -d roff -i $< -o $@

.7.ps:
	$(TROFF) -man $< > $@

.azm.html:
	$(ZOEM) -d html -i $< -o $@
	$(ZOEM) -d html -i $< -o $@
	- $(TIDY) -e $@

MAINTAINERCLEANFILES = $(man_MANS) $(typetargets)

