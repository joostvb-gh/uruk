# $Id: caspar.mk,v 1.7 2003-08-22 13:46:22 joostvb Exp $

# Copyright (C) 2002 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
# 
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# see the caspar README file (probably installed in
# /usr/local/share/doc/caspar/README) for usage

ifdef SDIR

ifdef SUHS
SRDIRS ?= $(patsubst %,%:$(SDIR),$(SUHS))
endif

ifdef SUH
SRDIRS ?= $(SUH):$(SDIR)
endif

endif

# possibility to choose own cp(1) and scp(1)
CP ?= cp
SCP ?= scp

# extra arguments for cp(1) and scp(1)
CPFLAGS ?=
SCPFLAGS ?=

CPDIRS ?= $(CDIR)

RULES = $(foreach dir,$(SRDIRS),$(SCP) $(SCPFLAGS) "$(subst -install,,$@)" $(dir);) \
	$(foreach dir,$(CPDIRS),$(CP) $(CPFLAGS) "$(subst -install,,$@)" $(dir);)

# files, not directories
FILES := $(shell for f in *; do test -f $$f && echo $$f; done)

# exclude editor backup files and other stuff
FILES := $(filter-out Makefile CVS %~ \#%\#, $(FILES))

TARGETS := $(patsubst %,%-install,$(FILES))
TARGETS := $(filter-out $(LOAD), $(TARGETS))

all: install load

install: $(TARGETS)

load: $(LOAD)

$(TARGETS):
	$(RULES)

.PHONY: $(TARGETS)
.PHONY: $(LOAD)

