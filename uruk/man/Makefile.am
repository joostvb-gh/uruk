## Process this file with automake to produce Makefile.in
## $Id: Makefile.am,v 1.16 2004/02/10 17:08:39 joostvb Exp $

## Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
## Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
## Copyright (C) 2003, 2004 Joost van Baal

## zoem hacks based upon work by Stijn van Dongen.

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

TROFF = groff
COL = col

## Zoem is a an interpretive macro language, for creating mark-up languages, by
## Stijn van Dongen. Information about zoem can be found on the zoem webpage at
## http://micans.org/zoem/ .
ZOEM = zoem

## tidy is a HTML syntax checker and reformatter, available from
## http://www.w3.org/People/Raggett/tidy/ , by Dave Raggett <dsr@w3.org>
TIDY = tidy -quiet

## http://w3m.sourceforge.net/
## w3m is a text-based web browser, which can be used as a text formatting tool
## which typesets HTML into plain text.
W3M = w3m

azms = uruk-rc.azm uruk.azm
typetargets = uruk-rc.html uruk-rc.ps uruk-rc.txt uruk.html uruk.ps uruk.txt
tmpfiles = uruk-rc.zmt uruk-rc.zmr uruk.zmt uruk.zmr

doc_DATA = $(typetargets) $(azms)
man_MANS = uruk.8 uruk-rc.5

EXTRA_DIST = $(azms)
DISTCLEANFILES = $(man_MANS) $(typetargets) $(tmpfiles)

VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

docdir = $(datadir)/doc/$(PACKAGE)

SUFFIXES = .5 .8 .html .azm .ps .txt

.azm.5:
	$(ZOEM) -d roff -i $< -o $@
	$(ZOEM) -d roff -i $< -o $@

.azm.8:
	$(ZOEM) -d roff -i $< -o $@
	$(ZOEM) -d roff -i $< -o $@

.5.ps:
	$(TROFF) -man $< > $@

.8.ps:
	$(TROFF) -man $< > $@

.azm.html:
	$(ZOEM) -d html -i $< -o $@
	$(ZOEM) -d html -i $< -o $@
## 	- $(TIDY) -e $@

## .html.txt:
## 	$(W3M) -dump $< > $@

.5.txt:
	$(TROFF) -t -e -mandoc -Tlatin1 $< | $(COL) -bxp > $@

.8.txt:
	$(TROFF) -t -e -mandoc -Tlatin1 $< | $(COL) -bxp > $@

