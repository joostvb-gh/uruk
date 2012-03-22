## Process this file with automake to produce Makefile.in
## This file is maintained at http://git.mdcc.cx/caspar

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003, 2004, 2005, 2006, 2010, 2011 Joost van Baal

## see booststrap for git2cl
ChangeLog: NEWS
	git log --pretty --numstat --summary | sed 's/<[^>][^>]*>//g' | git2cl >ChangeLog

VERSION.m4 VERSION stamp.year stamp.month stamp.day: ChangeLog
	./setversion

CONFIGURE_DEPENDENCIES = VERSION.m4

## Hook `dist-bzip2' to `dist'.
AUTOMAKE_OPTIONS = dist-bzip2 check-news

## used in make dist[check]
VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

SUBDIRS = doc mk sgml script

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog README THANKS TODO NEWS

## local targets
MY_RDIR = beskar:www/mdcc.cx/pub/caspar/

sign:
	for i in $(DIST_ARCHIVES); do echo "gpg --armor --detach-sign $$i"; gpg --armor --detach-sign $$i; done

publish:
	for i in $(DIST_ARCHIVES); do echo "scp $$i $$i.asc $(MY_RDIR)"; scp $$i $$i.asc $(MY_RDIR); done
	@echo now run ssh opal update-tar-symlinks caspar

## Only files from the current directory or from subdirectory which
## don't have their own Makefile.am should be listed here.
EXTRA_DIST = bootstrap setversion VERSION.m4 VERSION

