# $Id: caspar.mk,v 1.14 2005-02-23 09:29:07 joostvb Exp $

# Copyright (C) 2002, 2003, 2004 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# see the caspar README file (probably installed in
# /usr/local/share/doc/caspar/README) for usage

# backwards compatibility: old var names
ifdef CDIR
csp_CPDIR     ?= $(CDIR)
endif
ifdef CP
csp_CP       ?= $(CP)
endif
ifdef CPDIRS
csp_CPDIRS   ?= $(CPDIRS)
endif
ifdef CPFLAGS
csp_CPFLAGS  ?= $(CPFLAGS)
endif
ifdef LOAD
csp_LOAD     ?= $(LOAD)
endif
ifdef SCP
csp_SCP      ?= $(SCP)
endif
ifdef SCPFLAGS
csp_SCPFLAGS ?= $(SCPFLAGS)
endif
ifdef SDIR
csp_SCPDIR   ?= $(SDIR)
endif
ifdef SRDIRS
csp_SUHDIRS  ?= $(SRDIRS)
endif
ifdef SUH
csp_SUH      ?= $(SUH)
endif
ifdef SUHS
csp_SUHS     ?= $(SUHS)
endif
# end of backwards compatibility hack.  this hack was introduced in 2004-05.
# guess it should be removed at about 2005-05.


ifdef csp_SCPDIR

ifdef csp_SUHS
csp_SUHDIRS  ?= $(patsubst %,%:$(csp_SCPDIR),$(csp_SUHS))
endif

ifdef csp_SUH
csp_SUHDIRS  ?= $(csp_SUH):$(csp_SCPDIR)
endif

endif

# possibility to choose own cp(1) and scp(1)
csp_CP       ?= cp
csp_SCP      ?= scp

# extra arguments for cp(1) and scp(1)
csp_CPFLAGS  ?=
csp_SCPFLAGS ?=

csp_CPDIRS   ?= $(csp_CPDIR)

csp_TABOOFILES_DEFAULT ?= Makefile CVS %~ \#%\# pod2htmd.tmp pod2htmi.tmp
csp_TABOOFILES ?= $(filter-out $(csp_TABOOFILES_EXCLUDE), $(csp_TABOOFILES_DEFAULT)) $(csp_TABOOFILES_INCLUDE)

csp_TABOODIRS_DEFAULT ?= CVS
csp_TABOODIRS  ?= $(filter-out $(csp_TABOODIRS_EXCLUDE), $(csp_TABOODIRS_DEFAULT)) $(csp_TABOODIRS_INCLUDE)

RULES = $(foreach dir,$(csp_SUHDIRS),$(csp_SCP) $(csp_SCPFLAGS) "$(subst -install,,$@)" $(dir);) \
	$(foreach dir,$(csp_CPDIRS),$(csp_CP) $(csp_CPFLAGS) "$(subst -install,,$@)" $(dir);)

# files, not directories
FILES   := $(shell for f in *; do test -f $$f && echo $$f; done)

# exclude editor backup files and other stuff
FILES   := $(filter-out $(csp_TABOOFILES), $(FILES))

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

all: install load

install: $(TARGETS)

load: $(csp_LOAD)

$(TARGETS):
	$(RULES)

install-recursive: install
	$(do-recursive)

.PHONY: $(TARGETS)
.PHONY: $(csp_LOAD)

