divert(-1)
changequote([, ])
# $Id: Makefile.m4,v 1.2 2005-03-06 17:23:04 joostvb Exp $
# $Source: /cvsroot/caspar/caspar/solaris/pkg/Makefile.m4,v $

# Process this file with csbs's ( http://mdcc.cx/csbs ) bootstrap to
# generate a solaris/Makefile.

define([CSBS_VENDORTAG], [UVT])
define([CSBS_TARNAME], [caspar])
define([CSBS_UPVERSION], [20050302])
define([CSBS_PKGVERSION], [1])
# max 6 chars: some old solaris-en break otherwise
define([CSBS_SHORTTARNAME], [caspar])

include([csbs.m4])
divert(0)dnl
CSBS_ALL
