# general install file, to be included in Makefiles
# works for dumb directories, for which the repository
# only needs to be scp-ed to install environment as is

# the Makefile in the repository should define SRDIRS and CPDIRS

# $Id: install.mk,v 1.2 2002-02-26 19:13:14 joostvb Exp $

ifdef SUH
SRDIRS ?= $(SUH):$(DIR)
endif

RULES = $(foreach dir,$(SRDIRS),scp "$(subst -install,,$@)" $(dir);) \
	$(foreach dir,$(CPDIRS),cp "$(subst -install,,$@)" $(dir);)

# files, not directories
FILES := $(shell for f in *; do test -f $$f && echo -n $$f " "; done)
FILES := $(filter-out Makefile CVS %~, $(FILES))

TARGETS := $(patsubst %,%-install,$(FILES))
TARGETS := $(filter-out $(XXTARGETS), $(TARGETS))

all: install $(XXTARGETS)

install: $(TARGETS)

$(TARGETS):
	$(RULES)

# overrule timestamp check
.PHONY: $(TARGETS)
.PHONY: $(XXTARGETS)

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
