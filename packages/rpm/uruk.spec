# $Id: uruk.spec,v 1.8 2004/07/30 14:11:23 joostvb Exp $

# Copyright (C) 2004, 2005 Tilburg University http://www.uvt.nl/
#
# This file is part of uruk.  Uruk is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.  You should have received a copy of
# the GNU General Public License along with this file (see COPYING).

%define version 20040625
%define release 1

%define name uruk
%define source_ext gz

Summary:   Wrapper for Linux iptables, for filtering rules management
Name:      %{name}
Version:   %{version}
Release:   %{release}

Source0:   %{name}-%{version}.tar.%{source_ext}
Source1:   %{name}-source.1.README.RPM
Source2:   %{name}-source.2.TODO.RPM

# Patch0:    %{name}-patch.0.init-chkconfig

Copyright: GPL
Group:     Applications/System
Vendor:    Joost van Baal
URL:       http://mdcc.cx/uruk/

BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
Prefix:    %{_prefix}

%description
 Uruk is a wrapper for Linux iptables.  A very simple shell script, but useful
 if you need similar (but not the same) packet filtering configurations on lots
 of boxes.  It uses a template file, which gets source-d as a shell script, to
 get lists of source addresses, allowed to use specific network services.
 Listing these groups of allowed hosts and allowed services is all what's
 needed to configure your box.

%prep
%setup -q
# %patch0 -p1
cp %{_sourcedir}/%{name}-source.1.README.RPM README.RPM
cp %{_sourcedir}/%{name}-source.2.TODO.RPM TODO.RPM

%build
%configure
make

%install
rm -fr %{buildroot}
make DESTDIR=%{buildroot} install
rm -rf %{buildroot}/usr/share/doc/uruk
mkdir -p %{buildroot}/etc/rc.d/init.d
mv %{buildroot}/etc/init.d/uruk %{buildroot}/etc/rc.d/init.d/
rmdir %{buildroot}/etc/init.d

%clean
rm -rf %{buildroot}

%post
/sbin/chkconfig --add uruk

%preun
if test "$1" = 0
then
    /sbin/chkconfig --del uruk
fi

%files
%defattr(-,root,root)
%doc AUTHORS NEWS README THANKS TODO ChangeLog doc/rc man/uruk-rc.html man/uruk-rc.ps man/uruk-rc.txt man/uruk.html man/uruk.ps man/uruk.txt README.RPM TODO.RPM
%config /etc/rc.d/init.d/uruk
%{_sbindir}/uruk
%{_mandir}/man5/uruk-rc.5.gz
%{_mandir}/man8/uruk.8.gz

%changelog
*   Joost van Baal
- README.RPM: added hint on how to disable RH-style fw rules

* Fri Jul 30 2004 Joost van Baal <joostvb@uvt.nl> 20040625-1
- New upstream

* Mon Feb 16 2004 Joost van Baal <joostvb@uvt.nl> 20040216-1
- New upstream.  (Old one was _severely_ broken!)
- README.RPM: refer to sample rc file.

* Mon Feb 16 2004 Joost van Baal <joostvb@uvt.nl> 20040213-1
- Initial specfile.  Untested!

