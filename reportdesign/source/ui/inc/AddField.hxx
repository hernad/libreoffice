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

#ifndef INCLUDED_REPORTDESIGN_SOURCE_UI_INC_ADDFIELD_HXX
#define INCLUDED_REPORTDESIGN_SOURCE_UI_INC_ADDFIELD_HXX

#include <com/sun/star/lang/XComponent.hpp>
#include <com/sun/star/container/XNameAccess.hpp>
#include <com/sun/star/sdbc/XConnection.hpp>
#include <vcl/transfer.hxx>
#include <vcl/treelistbox.hxx>
#include <vcl/floatwin.hxx>
#include <comphelper/propmultiplex.hxx>
#include <comphelper/containermultiplexer.hxx>
#include <vcl/button.hxx>

#include <svx/dataaccessdescriptor.hxx>
#include <cppuhelper/basemutex.hxx>
#include <vcl/toolbox.hxx>
#include <vcl/fixed.hxx>

#include <rtl/ref.hxx>

namespace rptui
{

class OAddFieldWindow;
class OAddFieldWindowListBox;

class  OAddFieldWindow  :public FloatingWindow
                    ,   public ::cppu::BaseMutex
                    ,   public ::comphelper::OPropertyChangeListener
                    ,   public ::comphelper::OContainerListener
{
    css::uno::Reference< css::lang::XComponent>                                 m_xHoldAlive;
    css::uno::Reference< css::container::XNameAccess>                           m_xColumns;
    css::uno::Reference< css::beans::XPropertySet >                             m_xRowSet;

    VclPtr<ToolBox>                                                             m_aActions;

    VclPtr<OAddFieldWindowListBox>                                              m_pListBox;
    VclPtr<FixedText>                                                           m_aHelpText;

    Link<OAddFieldWindow&,void>                                                 m_aCreateLink;
    OUString                                                                    m_aCommandName;
    OUString                                                                    m_sFilter;
    sal_uInt16                                                                  m_nSortUpId;
    sal_uInt16                                                                  m_nSortDownId;
    sal_uInt16                                                                  m_nRemoveSortId;
    sal_uInt16                                                                  m_nInsertId;
    sal_Int32                                                                   m_nCommandType;
    bool                                                                        m_bEscapeProcessing;
    ::rtl::Reference< comphelper::OPropertyChangeMultiplexer>                   m_pChangeListener;
    ::rtl::Reference< comphelper::OContainerListenerAdapter>                    m_pContainerListener;

    DECL_LINK( OnDoubleClickHdl, SvTreeListBox*, bool );
    DECL_LINK( OnSelectHdl, SvTreeListBox*, void );
    DECL_LINK( OnSortAction, ToolBox*, void );

    OAddFieldWindow(const OAddFieldWindow&) = delete;
    void operator =(const OAddFieldWindow&) = delete;
public:
    OAddFieldWindow(vcl::Window* pParent
                    , const css::uno::Reference< css::beans::XPropertySet >& _xRowSet);

    virtual ~OAddFieldWindow() override;
    virtual void dispose() override;
    virtual void GetFocus() override;
    virtual bool PreNotify( NotifyEvent& _rNEvt ) override;

    const OUString&       GetCommand()            const { return m_aCommandName; }
    sal_Int32                    GetCommandType()        const { return m_nCommandType; }
    bool                     GetEscapeProcessing()   const { return m_bEscapeProcessing; }
    void SetCreateHdl(const Link<OAddFieldWindow&,void>& _aCreateLink) { m_aCreateLink = _aCreateLink; }

    css::uno::Reference< css::sdbc::XConnection>              getConnection() const;

    css::uno::Sequence< css::beans::PropertyValue > getSelectedFieldDescriptors();

    /// Updates the current field list
    void Update();

    /** fills the descriptor with the column name, column object, command and command type
    *
    * \param _pSelected the currently selected
    * \param _rDescriptor the descriptor will be filled
    */
    void fillDescriptor(SvTreeListEntry const * _pSelected,svx::ODataAccessDescriptor& _rDescriptor);

private:
    // FmXChangeListener
    virtual void _propertyChanged(const css::beans::PropertyChangeEvent& evt) override;
    // OContainerListener
    virtual void _elementInserted( const css::container::ContainerEvent& _rEvent ) override;
    virtual void _elementRemoved( const  css::container::ContainerEvent& _rEvent ) override;
    virtual void _elementReplaced( const css::container::ContainerEvent& _rEvent ) override;
};

} // rptui

#endif // INCLUDED_REPORTDESIGN_SOURCE_UI_INC_ADDFIELD_HXX

/* vim:set shiftwidth=4 softtabstop=4 expandtab: */
