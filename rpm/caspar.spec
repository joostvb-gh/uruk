# $Id: caspar.spec,v 1.4 2007-01-30 13:41:18 joostvb Exp $

# Copyright (C) 2004, 2007 Tilburg University http://www.uvt.nl/
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

%define version 20060618
%define name caspar
%define release 1
%define source_ext gz
%define make make

Summary: Makefile snippets for common tasks
Name:    %{name}
Version: %{version}
Release: %{release}
Source0: %{name}-%{version}.tar.%{source_ext}

Copyright: GPL
Group:     Applications/Devel
Vendor:    Joost van Baal
URL:       http://mdcc.cx/caspar/

BuildRoot:      %{_tmppath}/%{name}-%{version}-buildroot
Prefix:         %{_prefix}

%description
 Caspar offers Makefile snippets for common tasks, like installing system
 configuration files you maintain using CVS, or typesetting LaTeX, DocBook
 XML and DocBook SGML documents.  You'll need at least the jade, jadetex and
 LaTeX RPM's if you want to do any typesetting.

%prep
%setup -q

%build
%configure
# --docdir=/usr/share/doc/caspar-%{version}  : caspar is buggy
make

%install
rm -fr %{buildroot}
make DESTDIR=%{buildroot} install
rm -rf %{buildroot}/usr/share/doc/caspar

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%doc AUTHORS ChangeLog doc/ChangeLog.2002 NEWS README THANKS TODO doc/caspar-typesetting.azm doc/caspar-typesetting.html doc/caspar-typesetting.ps doc/caspar-typesetting.txt doc/caspar.azm doc/caspar.html doc/caspar.ps doc/caspar.txt
%{_bindir}/csp_sucp
%{_mandir}/man*/*
%{_datadir}/caspar/*
%{_datadir}/sgml/caspar/*
%{_includedir}/caspar/mk/*

# see also:
# Sep  8  2005 nagios-plugins/package/redhat/nagios-plugins.spec
# Nov 15  2005 nrpe/package/redhat/redhat/nrpe.spec
# Feb 17  2006 subversion/package/redhat/subversion.spec
# Dec 15  2005 xstow/package/rpm/xstow.spec


%changelog
* Tue Jan 30 2007 Joost van Baal <joostvb@uvt.nl>
- Release 20060618-1.  Still untested.

* Mon Jan 05 2004 Joost van Baal <joostvb@uvt.nl>
- initial specfile.  LaTeX and DocBook based typesetting probably broken
  in this package.  Very untested.  Would have been release 20030825-1, but
  never actually publised an RPM.

