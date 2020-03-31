# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_CustomTarget_CustomTarget,extras/source/autocorr))

extras_AUTOCORR_LANGS := \
	de:de \
	en-AU:en-AU \
	en-GB:en-GB \
	en-US:en-US \
	en-ZA:en-ZA \
	hr:hr-HR \

extras_AUTOCORR_XMLFILES := \
	de/DocumentList.xml \
	de/META-INF/manifest.xml \
	de/SentenceExceptList.xml \
	de/WordExceptList.xml \
	en-AU/DocumentList.xml \
	en-AU/META-INF/manifest.xml \
	en-AU/SentenceExceptList.xml \
	en-AU/WordExceptList.xml \
	en-GB/DocumentList.xml \
	en-GB/META-INF/manifest.xml \
	en-GB/SentenceExceptList.xml \
	en-GB/WordExceptList.xml \
	en-US/DocumentList.xml \
	en-US/META-INF/manifest.xml \
	en-US/SentenceExceptList.xml \
	en-US/WordExceptList.xml \
	en-ZA/DocumentList.xml \
	en-ZA/META-INF/manifest.xml \
	en-ZA/SentenceExceptList.xml \
	en-ZA/WordExceptList.xml \
	hr/DocumentList.xml \
	hr/META-INF/manifest.xml \
	hr/SentenceExceptList.xml \
	hr/WordExceptList.xml \


extras_AUTOCORR_MIMETYPEFILES := $(foreach lang,$(extras_AUTOCORR_LANGS),$(firstword $(subst :, ,$(lang)))/mimetype)


$(call gb_CustomTarget_get_target,extras/source/autocorr) : \
	$(foreach lang,$(extras_AUTOCORR_LANGS),$(call gb_CustomTarget_get_workdir,extras/source/autocorr)/acor_$(lastword $(subst :, ,$(lang))).dat)

$(call gb_CustomTarget_get_workdir,extras/source/autocorr)/%/mimetype : $(SRCDIR)/extras/source/autocorr/lang/%/mimetype
	$(call gb_Output_announce,autocorr/$*/mimetype,$(true),CPY,1)
	$(call gb_Trace_StartRange,autocorr/$*/mimetype,CPY)
	cp $< $@
	$(call gb_Trace_EndRange,autocorr/$*/mimetype,CPY)

$(call gb_CustomTarget_get_workdir,extras/source/autocorr)/%.xml : $(SRCDIR)/extras/source/autocorr/lang/%.xml \
		| $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,autocorr/$*.xml,$(true),XSL,1)
	$(call gb_Trace_StartRange,autocorr/$*.xml,XSL)
	$(call gb_ExternalExecutable_get_command,xsltproc) --nonet -o $@ $(SRCDIR)/extras/util/compact.xsl $<
	$(call gb_Trace_EndRange,autocorr/$*.xml,XSL)

$(call gb_CustomTarget_get_workdir,extras/source/autocorr)/%.dat :
	$(call gb_Output_announce,autocorr/$*.dat,$(true),ZIP,2)
	$(call gb_Trace_StartRange,autocorr/$*.dat,ZIP)
	$(call gb_Helper_abbreviate_dirs,\
		cd $(EXTRAS_AUTOCORR_DIR) && \
		zip -q0X --filesync --must-match $@ $(EXTRAS_AUTOCORR_MIMEFILES_FILTER) && \
		zip -qrX --must-match $@ $(EXTRAS_AUTOCORR_XMLFILES_FILTER) \
	)
	$(call gb_Trace_EndRange,autocorr/$*.dat,ZIP)

define extras_Autocorr_make_file_deps
$(call gb_CustomTarget_get_workdir,$(1))/$(2) : $(SRCDIR)/$(1)/lang/$(2) \
	| $(dir $(call gb_CustomTarget_get_workdir,$(1))/$(2)).dir

endef

define extras_Autocorr_make_zip_deps
$(call gb_CustomTarget_get_workdir,$(1))/$(2) : \
	$(addprefix $(call gb_CustomTarget_get_workdir,$(1))/,$(filter $(3)/%,$(extras_AUTOCORR_MIMETYPEFILES) $(extras_AUTOCORR_XMLFILES))) \
	| $(dir $(call gb_CustomTarget_get_workdir,$(1))/$(2)).dir

$(call gb_CustomTarget_get_workdir,$(1))/$(2) : \
	EXTRAS_AUTOCORR_MIMEFILES_FILTER := $(foreach file,$(filter $(3)/%,$(extras_AUTOCORR_MIMETYPEFILES)),$(subst $(3)/,,$(file)))
$(call gb_CustomTarget_get_workdir,$(1))/$(2) : \
	EXTRAS_AUTOCORR_XMLFILES_FILTER := $(foreach file,$(filter $(3)/%,$(extras_AUTOCORR_XMLFILES)),$(subst $(3)/,,$(file)))
$(call gb_CustomTarget_get_workdir,$(1))/$(2) : \
	EXTRAS_AUTOCORR_DIR := $(call gb_CustomTarget_get_workdir,$(1))/$(3)

endef

$(eval $(foreach file,$(extras_AUTOCORR_MIMETYPEFILES) $(extras_AUTOCORR_XMLFILES),\
	$(call extras_Autocorr_make_file_deps,extras/source/autocorr,$(file)) \
))

$(eval $(foreach lang,$(extras_AUTOCORR_LANGS),\
	$(call extras_Autocorr_make_zip_deps,extras/source/autocorr,acor_$(lastword $(subst :, ,$(lang))).dat,$(firstword $(subst :, ,$(lang)))) \
))

# vim: set noet sw=4 ts=4:
