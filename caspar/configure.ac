dnl
dnl $Id: configure.ac,v 1.2 2003-08-09 14:23:02 joostvb Exp $
dnl
dnl After editing this file, run automake to regenerate Makefile.in's.
dnl Process this file with autoconf to produce a configure script.

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

m4_include([VERSION.m4])dnl

AC_INIT([Caspar],
       [CASPAR_VERSION],
       [joostvb-caspar@mdcc.cx],
       [caspar])

AC_PREREQ(2.53)

AM_INIT_AUTOMAKE

AC_COPYRIGHT([
Copyright (C) 2002, 2003 Joost van Baal <joostvb-caspar-c-12@mdcc.cx>
])

AC_REVISION($Revision: 1.2 $)

AC_PROG_INSTALL

AC_CONFIG_FILES([
   Makefile
   doc/Makefile
   mk/Makefile
   sgml/Makefile
])

AC_OUTPUT
