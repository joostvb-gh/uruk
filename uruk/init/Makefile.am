## Process this file with automake to produce Makefile.in
## this file maintained at http://git.mdcc.cx/uruk.git

## Copyright (C) 2003, 2004 Joost van Baal
## Copyright (C) 2012, 2015 Joost van Baal-Ilić

## This script is free software; you can distribute it and/or modify it
## under the terms of the GNU GPL.  See the file COPYING.

initdir = $(sysconfdir)/init.d
init_SCRIPTS = uruk

## /lib/uruk/init/
initlibdir = $(libexecdir)/$(PACKAGE)/init
initlib_SCRIPTS = autodetect-ips enable-ipv6

# to be installed as /lib/systemd/system/uruk.service
systemddir = $(libexecdir)/systemd/system
systemd_DATA = uruk.service

EXTRA_DIST = $(init_SCRIPTS) $(initlib_SCRIPTS) $(systemd_DATA)
