# $Id: caspar.spec,v 1.2 2004-01-23 15:26:07 joostvb Exp $

# Copyright (C) 2004 Tilburg University http://www.uvt.nl/
#
# This file is part of caspar.  Caspar is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

%define version 20030825
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
make

%install
rm -fr %{buildroot}
make DESTDIR=%{buildroot} install

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%doc AUTHORS ChangeLog ChangeLog.2002 NEWS.gz README THANKS TODO caspar-typesetting.azm caspar-typesetting.html caspar-typesetting.ps.gz caspar-typesetting.txt caspar.azm.gz caspar.html caspar.ps.gz caspar.txt
%{_sbindir}/uvtscan
%{_bindir}/uvtscan_report
%{_mandir}/man7/caspar.7.gz
%{_mandir}/man7/caspar-typesetting.7.gz


# /usr/share/caspar/mk/caspar.mk
# /usr/share/caspar/mk/docbook.mk
# /usr/share/caspar/mk/pod.mk
#
# /usr/share/sgml/caspar/print.dsl
# /usr/share/sgml/caspar/html.dsl
#
# /usr/include/caspar/mk/caspar.mk
# /usr/include/caspar/mk/docbook.mk
# /usr/include/caspar/mk/pod.mk

%changelog
* Mon Jan 05 2004 Joost van Baal <joostvb@uvt.nl>
- initial specfile.  LaTeX and DocBook based typesetting probably broken
  in this package.  Very untested.

