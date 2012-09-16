## Process this file with automake to produce Makefile.in
## this file maintained at http://git.mdcc.cx/uruk.git

## Copyright (C) 2013 Joost van Baal-Ilić

## This script is free software; you can distribute it and/or modify it
## under the terms of the GNU GPL.  See the file COPYING.

PACKAGE = @PACKAGE_TARNAME@

# /lib/uruk/lsb/
lsbdir = $(libexecdir)/$(PACKAGE)/lsb

lsb_DATA = init-functions
lsb_SCRIPTS = lsb_killproc lsb_log_message lsb_pidofproc lsb_start_daemon

EXTRA_DIST = $(lsb_SCRIPTS) $(lsb_DATA)
