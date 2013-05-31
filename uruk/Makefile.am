## Process this file with automake to produce Makefile.in
## this file maintained at http://git.mdcc.cx/uruk.git

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

## Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
## Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
## Copyright (C) 2003, 2004, 2005 Joost van Baal
## Copyright (C) 2013 Joost van Baal-Ilić

## see booststrap for git2cl
## authors: joostvb,cgielen. DO display message id's.
ChangeLog: NEWS
	git log --pretty --numstat --summary | git2cl | sed 's/<[jc][^>][^>]*>//g' >ChangeLog

VERSION.m4 VERSION stamp.year stamp.month stamp.day: ChangeLog
	./setversion

CONFIGURE_DEPENDENCIES = VERSION.m4

## Hook `dist-bzip2' to `dist'.
AUTOMAKE_OPTIONS = dist-bzip2 check-news

## used in make dist[check]
VERSION = @PACKAGE_VERSION@
PACKAGE = @PACKAGE_TARNAME@

SUBDIRS = script man doc contrib init lsb

docdir = $(datadir)/doc/$(PACKAGE)
doc_DATA = AUTHORS COPYING ChangeLog ChangeLog.2003 README THANKS TODO

## local targets
MY_RDIR = beskar.mdcc.cx:www/mdcc.cx/pub/uruk/

sign:
	for i in $(DIST_ARCHIVES); do echo "gpg --armor --detach-sign $$i"; gpg --armor --detach-sign $$i; done

publish:
	for i in $(DIST_ARCHIVES); do echo "scp $$i $$i.asc $(MY_RDIR)"; scp $$i $$i.asc $(MY_RDIR); done
	@echo now run: ssh beskar update-tar-symlinks uruk
	@echo '( or: ssh beskar.mdcc.cx ./bin/update-tar-symlinks uruk )'

EXTRA_DIST = bootstrap ChangeLog.2003 setversion stamp.month stamp.year \
  stamp.day VERSION.m4 VERSION

