# pod.mk - typeset documentation from .pod files .  See perlpod(1) for
# information on Perl's pod, Plain Old Documention .
#
# See caspar-typesetting(7) for usage info.
#
# this Makefile snippet needs GNU Make

# Copyright (C) 2003 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# $Id: pod.mk,v 1.2 2003-08-09 14:24:17 joostvb Exp $

PODS := $(shell for f in *.pod; do test -f $$f && echo -n $$f " "; done)
BASES       := $(basename $(PODS))
TXTS        := $(patsubst %,%.txt,$(BASES))
OVERSTRIKES := $(patsubst %,%.overstrike-txt,$(BASES))
HTMLS       := $(patsubst %,%.html,$(BASES))
TROFFS      := $(patsubst %,%.7,$(BASES))
PSS         := $(patsubst %,%.ps,$(BASES))
PDFS        := $(patsubst %,%.pdf,$(BASES))

all: $(TXTS) $(HTMLS) $(TROFFS) $(PSS) $(PDFS)

%.7: %.pod
	pod2man $< $@

%.html: %.pod
	pod2html --infile=$< --outfile=$@

# view install.overstrike-txt with less(1)
%.overstrike-txt: %.pod
	pod2text --overstrike $< $@

%.txt: %.pod
	pod2text $< $@

# two pages on one sheet:
# a2ps -o $@ $<
%.ps: %.7
	man -l -Tps $< > $@

%.pdf: %.ps
	ps2pdf $< $@

clean:
	-rm -f *.pdf *.ps *.html *.txt *.overstrike-txt *.ps~ *.pdf~ *.7

