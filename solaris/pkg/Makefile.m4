divert(-1)
changequote([, ])
# $Id: Makefile.m4,v 1.3 2005-03-09 15:47:46 joostvb Exp $
# $Source: /cvsroot/caspar/caspar/solaris/pkg/Makefile.m4,v $

# Process this file with ./bootstrap to generate a solaris/Makefile.

define([CSBS_VENDORTAG], [UVT])
define([CSBS_TARNAME], [caspar])
define([CSBS_UPVERSION], [20050302])
define([CSBS_PKGVERSION], [2])
# max 6 chars: some old solaris-en break otherwise
define([CSBS_SHORTTARNAME], [caspar])

include([csbs.m4])
divert(0)dnl
CSBS_ALL
