# $Id: docbook.mk,v 1.9 2003-08-09 14:24:17 joostvb Exp $

# Copyright (C) 2002, 2003 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
#  
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# See caspar-typesetting(7) for usage information.

# see also /usr/local/src/debian/maint-guide/maint-guide-1.0.2/Makefile
# for a debiandoc-sgml example.

XMLDCL ?= /usr/share/sgml/declaration/xml.dcl

# my jade looks in "caspar/print.dsl",
#  "/usr/local/share/sgml/caspar/print.dsl",
#  "/usr/local/lib/sgml/caspar/print.dsl",
#  "/usr/share/sgml/caspar/print.dsl"
# when i specify -d caspar/print.dsl
#
# when using your own print.dsl, your Makefile could read
#
#  PRINT_DSL = print.dsl
#  include caspar/mk/docbook.mk
#
#
HTML_DSL ?= caspar/html.dsl
PRINT_DSL ?= caspar/print.dsl

# JADE = /usr/bin/jade
JADE ?= jade
# jade's -E option.  the jade default is 200.  we choose a maximum
# of 10 errors: we don't wanna have our console spammed by errormessages
JADE_MAXERRORS ?= 10

PDFJADETEX ?= pdfjadetex
PDFLATEX ?= pdflatex
JADETEX ?= jadetex
LATEX ?= latex

W3M ?= w3m
DVIPS ?= dvips
PSNUP ?= psnup

LPR ?= lpr
# gnome-gv might do well too
GV ?= gv

SGML2HTML_RULE = $(JADE) -E$(JADE_MAXERRORS) -t sgml -d $(HTML_DSL) $<

XML2HTML_RULE  = $(JADE) -E$(JADE_MAXERRORS) -t sgml -d $(HTML_DSL) \
  $(XMLDCL) $<

# lynx doesn't deal well with too wide blurbs of <literallayout>  :(
HTML2TXT_RULE  = $(W3M) -dump $< > $@

SGML2JTEX_RULE = $(JADE) -E$(JADE_MAXERRORS) -t tex -d $(PRINT_DSL) \
  -o $@ $<

XML2JTEX_RULE  = $(JADE) -E$(JADE_MAXERRORS) -t tex -d $(PRINT_DSL) \
  -o $@ $(XMLDCL) $<

# run three times for toc processing
JTEX2DVI_RULE  = $(JADETEX) $< && $(JADETEX) $< && $(JADETEX) $< && \
  rm -f $*.log $*.out $*.aux

# rm -f: intermediate files might not exist
JTEX2PDF_RULE = $(PDFJADETEX) $< && $(PDFJADETEX) $< && $(PDFJADETEX) $< && \
  rm -f $*.log $*.out $*.aux

TEX2DVI_RULE   = $(LATEX) $< && $(LATEX) $< && $(LATEX) $< && \
  rm -f $*.log $*.aux

DVI2PS_RULE    = $(DVIPS) -f < $< > $@
TEX2PDF_RULE   = $(PDFLATEX) $< && $(PDFLATEX) $< && $(PDFLATEX) $< && \
  rm -f $*.log $*.aux

PS22PS_RULE    = $(PSNUP) -2 $< $@

# create nice default target
sources := $(basename $(wildcard *.dbx *.tex *.sgml))
outputs := $(addsuffix .ps,$(sources)) $(addsuffix .pdf,$(sources)) \
  $(addsuffix .html,$(sources)) $(addsuffix  .txt,$(sources))

all: $(outputs)

%.jtex: %.sgml
	$(SGML2JTEX_RULE)

%.jtex: %.dbx
	$(XML2JTEX_RULE)

%.dvi: %.jtex
	$(JTEX2DVI_RULE)

%.dvi: %.tex
	$(TEX2DVI_RULE)

%.ps: %.dvi
	$(DVI2PS_RULE)

%.pdf: %.tex
	$(TEX2PDF_RULE)

%.pdf: %.jtex
	$(JTEX2PDF_RULE)

%.html: %.sgml
	$(SGML2HTML_RULE)

%.html: %.dbx
	$(XML2HTML_RULE)

%.txt: %.html
	$(HTML2TXT_RULE)

%.2ps: %.ps
	$(PS22PS_RULE)

%.view: %.ps
	$(GV) $<

%.print: %.2ps
	$(LPR) $<

%.printbig: %.ps
	$(LPR) $<

clean:
	-rm *.aux *.log *.dvi *.jtex

.PRECIOUS: %.ps %.html

