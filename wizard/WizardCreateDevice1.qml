// Copyright (c) 2014-2019, The Monero Project
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0

import ArqmaComponents.Wallet 1.0
import "../js/Wizard.js" as Wizard
import "../components"
import "../components" as ArqmaComponents

Rectangle {
    id: wizardCreateDevice1

    color: "transparent"
    property string viewName: "wizardCreateDevice1"

    property var deviceName: deviceNameModel.get(deviceNameDropdown.currentIndex).column2

    ListModel {
        id: deviceNameModel
        ListElement { column1: qsTr("Ledger") ; column2: "Ledger"; }
//        ListElement { column1: qsTr("Trezor") ; column2: "Trezor"; }
    }

    function update(){
        // update device dropdown
        deviceNameDropdown.update();
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter;
        width: parent.width - 100
        Layout.fillWidth: true
        anchors.horizontalCenter: parent.horizontalCenter;

        spacing: 0

        ColumnLayout {
            Layout.fillWidth: true
            Layout.topMargin: wizardController.wizardSubViewTopMargin
            Layout.maximumWidth: wizardController.wizardSubViewWidth
            Layout.alignment: Qt.AlignHCenter
            spacing: 20 * scaleRatio

            WizardHeader {
                title: qsTr("Create a new wallet") + translationManager.emptyString
                subtitle: qsTr("Using a hardware device.") + translationManager.emptyString
            }

            WizardWalletInput{
                id: walletInput
            }

            GridLayout {
                Layout.topMargin: 10 * scaleRatio
                Layout.fillWidth: true

                columnSpacing: 20 * scaleRatio
                columns: 2

                ArqmaComponents.LineEdit {
                    id: restoreHeight
                    Layout.fillWidth: true

                    labelText: qsTr("Restore height (optional)") + translationManager.emptyString
                    labelFontSize: 14 * scaleRatio
                    placeholderFontSize: 16 * scaleRatio
                    placeholderText: "0"
                    validator: RegExpValidator { regExp: /(\d+)?$/ }
                }

                ArqmaComponents.LineEdit {
                    id: lookahead
                    Layout.fillWidth: true

                    labelText: qsTr("Subaddress lookahead (optional)") + translationManager.emptyString
                    labelFontSize: 14 * scaleRatio
                    placeholderText: "<major>:<minor>"
                    placeholderFontSize: 16 * scaleRatio
                    validator: RegExpValidator { regExp: /(\d+):(\d+)?$/ }
                }
            }

            ColumnLayout {
                spacing: 0

                Layout.topMargin: 10 * scaleRatio
                Layout.fillWidth: true

                ColumnLayout{
                    ArqmaComponents.StandardDropdown {
                        id: deviceNameDropdown
                        dataModel: deviceNameModel
                        Layout.fillWidth: true
                        Layout.topMargin: 6 * scaleRatio
                        releasedColor: "#363636"
                        pressedColor: "#202020"
                    }
                }
            }

            TextArea {
                id: errorMsg
                text: qsTr("Error writing wallet from hardware device. Check application logs.") + translationManager.emptyString;
                visible: errorMsg.text !== ""
                Layout.fillWidth: true
                font.family: ArqmaComponents.Style.fontRegular.name
                color: ArqmaComponents.Style.infoRed
                font.pixelSize: 16 * scaleRatio

                selectionColor: ArqmaComponents.Style.dimmedFontColor
                selectedTextColor: ArqmaComponents.Style.defaultFontColor

                selectByMouse: true
                wrapMode: Text.WordWrap
                textMargin: 0
                leftPadding: 0
                topPadding: 0
                bottomPadding: 0
                readOnly: true
            }

            WizardNav {
                progressSteps: 4
                progress: 1
                btnNext.enabled: walletInput.verify();
                btnPrev.text: qsTr("Back to menu") + translationManager.emptyString
                btnNext.text: qsTr("Create wallet") + translationManager.emptyString
                onPrevClicked: {
                    wizardStateView.state = "wizardHome";
                }
                onNextClicked: {
                    wizardController.walletOptionsName = walletInput.walletName.text;
                    wizardController.walletOptionsLocation = walletInput.walletLocation.text;
                    wizardController.walletOptionsDeviceName = wizardCreateDevice1.deviceName;

                    if(restoreHeight.text)
                        wizardController.walletOptionsRestoreHeight = parseInt(restoreHeight.text);
                    if(lookahead.text)
                        wizardController.walletOptionsSubaddressLookahead = lookahead.text;

                    var written = wizardController.createWalletFromDevice();
                    if(written){
                        wizardController.walletOptionsIsRecoveringFromDevice = true;
                        wizardStateView.state = "wizardCreateWallet2";
                    } else {
                        errorMsg.text = qsTr("Error writing wallet from hardware device. Check application logs.") + translationManager.emptyString;
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        errorMsg.text = "";
        wizardCreateDevice1.update();
        console.log()
    }
}
