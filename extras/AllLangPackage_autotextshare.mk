# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangPackage_AllLangPackage,autotextshare,$(call gb_CustomTarget_get_workdir,extras/source/autotext)))

$(eval $(call gb_AllLangPackage_add_files,autotextshare,$(LIBO_SHARE_FOLDER)/autotext,\
	bs/standard.bau \
	de/crdbus50.bau \
	de/standard.bau \
	de/template.bau \
	en-GB/crdbus50.bau \
	en-GB/standard.bau \
	en-GB/template.bau \
	en-US/crdbus50.bau \
	en-US/standard.bau \
	en-US/template.bau \
	en-ZA/standard.bau \
	hr/standard.bau \
))

# vim: set noet sw=4 ts=4:
