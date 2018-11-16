## Process this file with automake to produce Makefile.in
## this file maintained at http://git.mdcc.cx/uruk.git

## Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
## Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
## Copyright (C) 2003, 2004, 2005 Joost van Baal

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

azms = uruk-rc.azm uruk-save.azm uruk.azm urukctl.azm
typetargets = uruk-rc.html uruk-rc.ps uruk-rc.txt \
  uruk-save.html uruk-save.ps uruk-save.txt uruk.html uruk.ps uruk.txt \
  urukctl.html urukctl.ps urukctl.txt
tmpfiles = uruk-rc.zmt uruk-rc.zmr uruk-save.zmt uruk-save.zmr \
  uruk.zmt uruk.zmr urukctl.zmt urukctl.zmr

doc_DATA = $(typetargets) $(azms)
man_MANS = uruk.8 uruk-rc.5 uruk-save.8 urukctl.8

EXTRA_DIST = $(doc_DATA) $(man_MANS)

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

## -Tlatin1 causes col to choke
## use -Tuft8 if you really need non-ascii characters
.5.txt:
	$(TROFF) -t -e -mandoc -Tascii $< | $(COL) -bxp > $@

.8.txt:
	$(TROFF) -t -e -mandoc -Tascii $< | $(COL) -bxp > $@

MAINTAINERCLEANFILES = $(typetargets) $(tmpfiles) $(man_MANS)
DISTCLEANFILES = $(typetargets)
