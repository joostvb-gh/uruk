dnl
dnl This file is maintained at http://git.mdcc.cx/caspar
dnl
dnl After editing this file, run automake to regenerate Makefile.in's.
dnl Process this file with autoconf to produce a configure script.

# This script is free software; you can distribute it and/or modify it
# under the terms of the GNU GPL.  See the file COPYING.

m4_include([VERSION.m4])dnl

AC_INIT([Caspar],
       [AD1_VERSION],
       [joostvb-caspar@mdcc.cx],
       [caspar])

AC_PREREQ(2.67)
AM_INIT_AUTOMAKE

AC_COPYRIGHT([
Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2009, 2010 Joost van Baal <joostvb-caspar@mdcc.cx>
Copyright (C) 2012, 2013, 2014 Joost van Baal-Ilić <joostvb-caspar@mdcc.cx>
])

AC_REVISION([AD1_VERSION])

AC_PROG_INSTALL
AC_PROG_LN_S

AC_CONFIG_FILES([
   Makefile
   doc/Makefile
   mk/Makefile
   sgml/Makefile
   script/Makefile
])

AC_OUTPUT
