## Process this file with automake to produce Makefile.in
## this file maintained at http://git.mdcc.cx/uruk.git

sbin_SCRIPTS = uruk urukctl uruk-save
EXTRA_DIST = $(sbin_SCRIPTS) uruk.in

uruk: uruk.in
	sed 's/@URUK_VERSION@/@PACKAGE_VERSION@/' $< >$@
