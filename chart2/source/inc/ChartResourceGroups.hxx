/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * This file incorporates work covered by the following license notice:
 *
 *   Licensed to the Apache Software Foundation (ASF) under one or more
 *   contributor license agreements. See the NOTICE file distributed
 *   with this work for additional information regarding copyright
 *   ownership. The ASF licenses this file to you under the Apache
 *   License, Version 2.0 (the "License"); you may not use this file
 *   except in compliance with the License. You may obtain a copy of
 *   the License at http://www.apache.org/licenses/LICENSE-2.0 .
 */

#ifndef INCLUDED_CHART2_SOURCE_CHARTRESOURCEGROUPS_HXX
#define INCLUDED_CHART2_SOURCE_CHARTRESOURCEGROUPS_HXX

#include <strings.hrc>
#include "ResId.hxx"

#include "res_BarGeometry.hxx"
#include "ChangingResource.hxx"
#include "ChartTypeDialogController.hxx"

#include <vcl/tabpage.hxx>

#include <com/sun/star/chart2/XChartDocument.hpp>

namespace chart
{
using namespace ::com::sun::star;
using namespace ::com::sun::star::chart2;

enum
{
    POS_3DSCHEME_SIMPLE = 0,
    POS_3DSCHEME_REALISTIC = 1
};

class Dim3DLookResourceGroup : public ChangingResource
{
public:
    explicit Dim3DLookResourceGroup(weld::Builder* pBuilder);

    void showControls(bool bShow);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter);

private:
    DECL_LINK(Dim3DLookCheckHdl, weld::ToggleButton&, void);
    DECL_LINK(SelectSchemeHdl, weld::ComboBox&, void);

private:
    std::unique_ptr<weld::CheckButton> m_xCB_3DLook;
    std::unique_ptr<weld::ComboBox> m_xLB_Scheme;
};

class SortByXValuesResourceGroup : public ChangingResource
{
public:
    explicit SortByXValuesResourceGroup(weld::Builder* pBuilder);

    void showControls(bool bShow);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter);

private:
    DECL_LINK(SortByXValuesCheckHdl, weld::ToggleButton&, void);

private:
    std::unique_ptr<weld::CheckButton> m_xCB_XValueSorting;
};

class StackingResourceGroup : public ChangingResource
{
public:
    explicit StackingResourceGroup(weld::Builder* pBuilder);

    void showControls(bool bShow, bool bShowDeepStacking);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter);

private:
    DECL_LINK(StackingChangeHdl, weld::ToggleButton&, void);
    DECL_LINK(StackingEnableHdl, weld::ToggleButton&, void);

private:
    std::unique_ptr<weld::CheckButton> m_xCB_Stacked;
    std::unique_ptr<weld::RadioButton> m_xRB_Stack_Y;
    std::unique_ptr<weld::RadioButton> m_xRB_Stack_Y_Percent;
    std::unique_ptr<weld::RadioButton> m_xRB_Stack_Z;
};

class SplinePropertiesDialog : public weld::GenericDialogController
{
public:
    explicit SplinePropertiesDialog(weld::Window* pParent);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter, bool bSmoothLines);

private:
    DECL_LINK(SplineTypeListBoxHdl, weld::ComboBox&, void);

private:
    std::unique_ptr<weld::ComboBox> m_xLB_Spline_Type;
    std::unique_ptr<weld::SpinButton> m_xMF_SplineResolution;
    std::unique_ptr<weld::Label> m_xFT_SplineOrder;
    std::unique_ptr<weld::SpinButton> m_xMF_SplineOrder;
};

const sal_uInt16 CUBIC_SPLINE_POS = 0;
const sal_uInt16 B_SPLINE_POS = 1;

class SteppedPropertiesDialog : public weld::GenericDialogController
{
public:
    explicit SteppedPropertiesDialog(weld::Window* pParent);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter, bool bSteppedLines);

private:
    std::unique_ptr<weld::RadioButton> m_xRB_Start;
    std::unique_ptr<weld::RadioButton> m_xRB_End;
    std::unique_ptr<weld::RadioButton> m_xRB_CenterX;
    std::unique_ptr<weld::RadioButton> m_xRB_CenterY;
};

#define POS_LINETYPE_STRAIGHT 0
#define POS_LINETYPE_SMOOTH 1
#define POS_LINETYPE_STEPPED 2

class SplineResourceGroup : public ChangingResource
{
public:
    explicit SplineResourceGroup(weld::Builder* pBuilder, weld::Window* pParent);

    void showControls(bool bShow);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter);

private:
    DECL_LINK(LineTypeChangeHdl, weld::ComboBox&, void);
    DECL_LINK(SplineDetailsDialogHdl, weld::Button&, void);
    DECL_LINK(SteppedDetailsDialogHdl, weld::Button&, void);
    SplinePropertiesDialog& getSplinePropertiesDialog();
    SteppedPropertiesDialog& getSteppedPropertiesDialog();

private:
    weld::Window* m_pParent;
    std::unique_ptr<weld::Label> m_xFT_LineType;
    std::unique_ptr<weld::ComboBox> m_xLB_LineType;
    std::unique_ptr<weld::Button> m_xPB_DetailsDialog;
    std::unique_ptr<SplinePropertiesDialog> m_xSplinePropertiesDialog;
    std::unique_ptr<SteppedPropertiesDialog> m_xSteppedPropertiesDialog;
};

class GeometryResourceGroup : public ChangingResource
{
public:
    explicit GeometryResourceGroup(weld::Builder* pBuilder);

    void showControls(bool bShow);

    void fillControls(const ChartTypeParameter& rParameter);
    void fillParameter(ChartTypeParameter& rParameter);

private:
    DECL_LINK(GeometryChangeHdl, weld::TreeView&, void);

private:
    BarGeometryResources m_aGeometryResources;
};

} //namespace chart
#endif

/* vim:set shiftwidth=4 softtabstop=4 expandtab: */
