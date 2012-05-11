# This file is maintained at http://git.mdcc.cx/caspar

# Copyright (C) 2012 Joost van Baal-Ilić <joostvb-caspar-c-12@mdcc.cx>
# Copyright (C) 2002, 2003, 2004, 2005, 2006, 2009, 2010 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# see caspar(7) for usage

# we use plurals only
csp_UHOSTS     ?= $(csp_UHOST)

ifneq ($(csp_UHOSTS_SUBSET),)
csp_UHOSTS     := $(filter $(csp_UHOSTS_SUBSET),$(csp_UHOSTS))
endif 
# uhosts that should be excluded for whatever reason
csp_UHOSTS     := $(filter-out $(csp_UHOSTS_SKIP),$(csp_UHOSTS))

# possibility to choose own cp(1) and scp(1)
csp_CP         ?= cp
csp_SCP        ?= scp
csp_SUCP       ?= csp_sucp
csp_SSH        ?= ssh
csp_CAT        ?= cat
csp_Diff       ?= diff     # csp_DIFF is reserved for the user interface...
csp_RSYNC      ?= rsync
csp_MKDIRP     ?= mkdir -p
csp_INSTALL    ?= csp_install
csp_SCP_KEEP_MODE ?= csp_scp_keep_mode

# extra arguments for cp(1) and scp(1)
csp_CPFLAGS    ?=
csp_SCPFLAGS   ?=
csp_RSYNCFLAGS ?= -zPt --chmod=ugo=rwX
csp_DIFFXARG   ?= -u

csp_EXTRAFILES ?=

csp_TABOOFILES_DEFAULT ?= Makefile .%.swp %~ \#%\# pod2htmd.tmp pod2htmi.tmp
csp_TABOOFILES ?= $(filter-out $(csp_TABOOFILES_SKIP),$(csp_TABOOFILES_DEFAULT)) $(csp_TABOOFILES_ADD)

csp_TABOODIRS_DEFAULT ?= CVS .svn
csp_TABOODIRS  ?= $(filter-out $(csp_TABOODIRS_SKIP),$(csp_TABOODIRS_DEFAULT)) $(csp_TABOODIRS_ADD)

# wrap csp_SCP and other puch mechanisms in make function template
csp_scp_FUNC    = $(csp_SCP) $(csp_SCPFLAGS) $(3) $(1):$(2)
csp_cp_FUNC     = $(csp_CP) $(csp_CPFLAGS) -t $(2) $(3)
csp_sucp_FUNC   = CSP_SUCP_USER=$(csp_SUCP_USER) $(csp_SUCP) $(1) $(2) $(3)
csp_rsync_FUNC  = $(csp_RSYNC) $(csp_RSYNCFLAGS) $(3) $(1)::$(2)
csp_rsyncssh_FUNC = $(csp_RSYNC) $(csp_RSYNCFLAGS) $(3) $(1):$(2)
csp_diff_FUNC   = $(csp_SSH) $(1) $(csp_CAT) $(2)/$(3) | $(csp_Diff) $(csp_DIFFXARG) - $(3)
csp_install_FUNC = $(csp_INSTALL) $(2) $(3)
csp_scp_keep_mode_FUNC = $(csp_SCP_KEEP_MODE) $(1) $(2) $(3)
csp_scpmkdir_FUNC = $(csp_SSH) $(1) $(csp_MKDIRP) $(2) && $(csp_scp_FUNC)

csp_PUSH       ?= $(csp_scp_FUNC)
csp_DIFF       ?= $(csp_diff_FUNC)

# files, not directories
FILES   := $(shell for f in *; do test -f "$$f" && echo "$$f"; done)

# exclude editor backup files and other stuff
FILES   := $(filter-out $(csp_TABOOFILES),$(FILES))

# user specified files and built files
FILES   := $(sort $(FILES) $(csp_EXTRAFILES) $(csp_BUILD))

all:
	$(MAKE) build
	$(MAKE) install
	$(MAKE) load

define filetargets
$1-install: $(foreach host,$(csp_UHOSTS),$1--$(host)--push)
$1-diff: $(foreach host,$(csp_UHOSTS),$1--$(host)--diff)
endef

define bulktargets
$2--bulk-push: $1
	$$(call csp_PUSH,$2,$$(csp_DIR),$1)
endef

$(foreach host,$(csp_UHOSTS),\
	$(eval $(call bulktargets,$(FILES),$(host))))

define remotetargets
$1--$2--push: $1
	$$(call csp_PUSH,$2,$$(csp_DIR),$1)

$1--$2--diff: $1
	$$(call csp_DIFF,$2,$$(csp_DIR),$1)
endef

$(foreach file,$(FILES),\
	$(eval $(call filetargets,$(file)))\
	$(foreach host,$(csp_UHOSTS),\
		$(eval $(call remotetargets,$(file),$(host)))))

define loadtarget
$1: $(patsubst %,$1--%--load,$(csp_UHOSTS))
endef

define loadtargets
$1--$2--load:
	$$(call $1,$2)
endef

$(foreach load,$(csp_LOAD),\
	$(eval $(call loadtarget,$(load)))\
	$(foreach host,$(csp_UHOSTS),\
	$(eval $(call loadtargets,$(load),$(host)))))

TARGETS := $(patsubst %,%-install,$(FILES))

BULKTARGETS := $(patsubst %,%--bulk-push,$(csp_UHOSTS))

DIFFTARGETS := $(patsubst %,%-diff,$(FILES))

DIRS    := $(shell for d in *; do test -d "$$d" && echo "$$d"; done)
DIRS    := $(filter-out $(csp_TABOODIRS),$(DIRS))

define do-recursive
$1--install-recursive:
	$(MAKE) -C $1 install-recursive
endef

$(foreach dir,$(DIRS),$(eval $(call do-recursive,$(dir))))

build: $(csp_BUILD)

diff: $(DIFFTARGETS)

install: $(BULKTARGETS)

load: $(csp_LOAD)

install-recursive: install $(patsubst %,%--install-recursive,$(DIRS))

debug:
	@echo TARGETS $(TARGETS) BULKTARGETS $(BULKTARGETS) FILES $(FILES) csp_UHOSTS $(csp_UHOSTS) csp_PUSH $(csp_PUSH)

.PHONY: $(csp_BUILD) $(TARGETS) $(BULKTARGETS) $(LOADTARGETS) $(DIFFTARGETS) $(csp_LOAD) build install load
