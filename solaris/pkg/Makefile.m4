divert(-1)
changequote([, ])
# $Id: Makefile.m4,v 1.1 2005-03-03 14:38:49 joostvb Exp $
# $Source: /cvsroot/caspar/caspar/solaris/pkg/Makefile.m4,v $

# Process this file with csbs's ( http://mdcc.cx/csbs ) bootstrap to
# generate a solaris/Makefile.

define([VENDORTAG], [UVT])
define([TARNAME], [caspar])
define([UPVERSION], [20050302])
define([PKGVERSION], [1])
# max 6 chars: some old solaris-en break otherwise
define([SHORTTARNAME], [caspar])

include([csbs.m4])
divert(0)dnl
CSBS_ALL
