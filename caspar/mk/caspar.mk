# $Id: caspar.mk,v 1.1 2002-02-27 16:53:27 joostvb Exp $

# Copyright (C) 2002 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
# 
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

# the Makefile in the repository should define SRDIRS and CPDIRS

ifdef SUH
SRDIRS ?= $(SUH):$(SDIR)
endif

CPDIRS ?= $(CDIR)

RULES = $(foreach dir,$(SRDIRS),scp "$(subst -install,,$@)" $(dir);) \
	$(foreach dir,$(CPDIRS),cp "$(subst -install,,$@)" $(dir);)

# files, not directories
FILES := $(shell for f in *; do test -f $$f && echo -n $$f " "; done)
FILES := $(filter-out Makefile CVS %~, $(FILES))

TARGETS := $(patsubst %,%-install,$(FILES))
TARGETS := $(filter-out $(LOAD), $(TARGETS))

all: install load

install: $(TARGETS)

load: $(LOAD)

$(TARGETS):
	$(RULES)

.PHONY: $(TARGETS)
.PHONY: $(LOAD)

#############################################################
#
# a makefile could like this:
#
# #!/usr/bin/make -f
#
# SRDIRS = user@sshreachablehost:bin/ \
#       otheruser@othersshreachablehost:script/
# # as you see, it's not needed to specify a list of
# # RRDIRS, if it would be empty anyway
#
# XSRDIRS = $(SRDIRS)
#
# # XFILES: a list of file which should not be installed in
# # SRDIRS and RRDIRS, but in XRRDIRS and XSRDIRS
# XFILES = afilename
#
# # XXFILES: a list of files for which we've got our own rules
# XXFILES = afile
#
# include ../../include/Makefile.geninst
#
# afile:
#     script < afile    
#
# # end of example Makefile
#
