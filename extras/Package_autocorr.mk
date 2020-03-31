# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_Package_Package,extras_autocorr,$(call gb_CustomTarget_get_workdir,extras/source/autocorr)))

$(eval $(call gb_Package_add_files,extras_autocorr,$(LIBO_SHARE_FOLDER)/autocorr,\
	acor_de.dat \
	acor_en-AU.dat \
	acor_en-GB.dat \
	acor_en-US.dat \
	acor_en-ZA.dat \
	acor_hr-HR.dat \
))

# vim: set noet sw=4 ts=4:
