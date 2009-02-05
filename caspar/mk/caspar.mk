# $Id: caspar.mk,v 1.40 2009-02-05 14:03:57 joostvb Exp $

# Copyright (C) 2002, 2003, 2004, 2005, 2006 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# see caspar(7) for usage

# we use plurals only
csp_CPDIRS     ?= $(csp_CPDIR)
csp_UHOSTS     ?= $(csp_UHOST)

ifneq ($(csp_UHOSTS_SUBSET),)
csp_UHOSTS     := $(filter $(csp_UHOSTS_SUBSET),$(csp_UHOSTS))
endif

# backward compatibility
ifneq ($(csp_SCPDIR),)
ifneq ($(csp_SUHS),)
csp_SUHDIRS    ?= $(patsubst %,%:$(csp_SCPDIR),$(csp_SUHS))
endif
ifneq ($(csp_SUH),)
csp_SUHDIRS    ?= $(csp_SUH):$(csp_SCPDIR)
endif
endif

# possibility to choose own cp(1) and scp(1)
csp_CP         ?= cp
csp_SCP        ?= scp
csp_SUCP       ?= csp_sucp

# extra arguments for cp(1) and scp(1)
csp_CPFLAGS    ?=
csp_SCPFLAGS   ?=

csp_EXTRAFILES ?=

csp_TABOOFILES_DEFAULT ?= Makefile .%.swp %~ \#%\# pod2htmd.tmp pod2htmi.tmp
csp_TABOOFILES ?= $(filter-out $(csp_TABOOFILES_SKIP), $(csp_TABOOFILES_DEFAULT)) $(csp_TABOOFILES_ADD)

csp_TABOODIRS_DEFAULT ?= CVS .svn
csp_TABOODIRS  ?= $(filter-out $(csp_TABOODIRS_SKIP), $(csp_TABOODIRS_DEFAULT)) $(csp_TABOODIRS_ADD)

# wrap csp_SCP and other puch mechanisms in make function template
csp_scp_FUNC    = $(csp_SCP) $(csp_SCPFLAGS) $(1) $(2):$(3)
csp_cp_FUNC     = $(csp_CP) $(csp_CPFLAGS) $(1) $(3)
csp_sucp_FUNC   = $(csp_SUCP) $(1) $(2) $(3) $(4)

csp_PUSH       ?= $(csp_scp_FUNC)

# ideally, we'd just have one rule here:
## RULES = $(foreach dir,$(csp_SUHDIRS),$(call csp_scp_FUNC,"$(subst -install,,$@)",$(dir);)
# however, since we might like to talk about e.g. csp_scp_UHOSTS when calling ssh in a load rule,
# we stick with these 3 rules for now.
#
RULES = $(foreach dir,$(csp_SUHDIRS),$(csp_SCP) $(csp_SCPFLAGS) "$(@:-install=)" $(dir);) \
	$(foreach dir,$(csp_CPDIRS),$(csp_CP) $(csp_CPFLAGS) "$(@:-install=)" $(dir);) \
	$(foreach uh,$(csp_UHOSTS),$(call csp_PUSH,"$(@:-install=)",$(uh),$(csp_DIR),$(csp_XARG));)

# files, not directories
FILES   := $(shell for f in *; do test -f $$f && echo $$f; done)

# exclude editor backup files and other stuff
FILES   := $(filter-out $(csp_TABOOFILES), $(FILES)) $(csp_EXTRAFILES)

TARGETS := $(patsubst %,%-install,$(FILES))
TARGETS := $(filter-out $(csp_LOAD), $(TARGETS))

DIRS    := $(shell for d in *; do test -d $$d && echo $$d; done)
DIRS    := $(filter-out $(csp_TABOODIRS), $(DIRS))

define do-recursive
for subdir in $(DIRS); \
do \
    (cd $$subdir && $(MAKE) -$(MAKEFLAGS) install-recursive); \
done
endef

all: build install load

build: $(csp_BUILD)

install: $(TARGETS)

load: $(csp_LOAD)

$(TARGETS):
	$(RULES)

install-recursive: install
	$(do-recursive)

.PHONY: $(csp_BUILD) $(TARGETS) $(csp_LOAD) build install load

