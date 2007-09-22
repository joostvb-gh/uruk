# Based upon autoscan(1) output.
# This file maintained using arch at http://arch.gna.org/uruk/
# Process this file with autoconf to produce a configure script.

# This script is free software; you can distribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This script is distributed WITHOUT ANY WARRANTY.
#
# You should have received a copy of the GNU GPL along with this script
# (e.g. in the file COPYING). If not, see <http://www.gnu.org/licenses/>.

# We have to use m4_include here: autoconf doesn't do includes natively
# we can't use aclocal.m4 / acinclude.m4 (which is added to aclocal.m4 by
# aclocal) neither:
#    "Every `configure' script must call `AC_INIT' before doing anything
#    else."
m4_include([VERSION.m4])dnl

# Initializing `configure'
#
#    It is preferable that the arguments of `AC_INIT' be static, i.e.,
#    there should not be any shell computation, but they can be
#    computed by M4.
AC_INIT([Uruk],
       [AD1_VERSION],
       [joostvb-uruk@mdcc.cx],
       [uruk])

AC_PREREQ(2.53)

AM_INIT_AUTOMAKE

AC_COPYRIGHT([
Copyright (C) 2003 Stichting LogReport Foundation logreport@logreport.org
Copyright (C) 2003, 2004 Tilburg University http://www.uvt.nl/
Copyright (C) 2003, 2004, 2005 Joost van Baal
])

AC_REVISION([AD1_VERSION])

# AC_DEFINE_DIR is defined in acinclude.m4
AC_DEFINE_DIR(BIN_PATH, bindir)
AC_DEFINE_DIR(SBIN_PATH, sbindir)
AC_DEFINE_DIR(DATA_PATH, datadir)
AC_DEFINE_DIR(SYSCONF_PATH, sysconfdir)
AC_DEFINE_DIR(LOCALSTATE_PATH, localstatedir)

AC_CHECK_PROG(HASZOEM, zoem, yes, no)
if test "xno" = "x$HASZOEM"
then
 AC_MSG_ERROR([cannot find zoem ( http://micans.org/zoem ) in your PATH ])
fi

AC_CHECK_PROG(HASGROFF, groff, yes, no)
if test "xno" = "x$HASGROFF"
then
 AC_MSG_ERROR([cannot find groff in your PATH])
fi

AC_CHECK_PROG(HASGROFF, col, yes, no)
if test "xno" = "x$HASCOL"
then
 AC_MSG_ERROR([cannot find col in your PATH])
fi


AC_CONFIG_FILES([Makefile
                 doc/Makefile
                 init/Makefile
                 init/uruk
                 man/Makefile
                 man/include.zmm
                 script/Makefile
                 script/uruk
                 script/uruk-save])
AC_OUTPUT

