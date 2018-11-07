// Copyright (c) 2014-2018, The Monero Project
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

import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: titleBar

    height: {
        if(!customDecorations || isMobile){
            return 0;
        }

        if(small) return 38 * scaleRatio;
        else return 50 * scaleRatio;
    }
    y: -height
    z: 1

    property string title
    property int mouseX: 0
    property bool containsMouse: false
    property alias basicButtonVisible: goToBasicVersionButton.visible
    property bool customDecorations: persistentSettings.customDecorations
    property bool showWhatIsButton: true
    property bool showMinimizeButton: false
    property bool showMaximizeButton: false
    property bool showCloseButton: true
    property bool showArqmaLogo: false
    property bool small: false

    signal closeClicked
    signal maximizeClicked
    signal minimizeClicked
    signal goToBasicVersion(bool yes)

    Item {
        // Background gradient
        width: parent.width
        height: parent.height
        z: parent.z + 1

        Image {
           anchors.fill: parent
           height: titleBar.height
           width: titleBar.width
           source: "../images/titlebarGradient.jpg"
        }
    }

    Item {
        id: titlebarlogo
        width: 125
        height: parent.height
        anchors.centerIn: parent
        visible: customDecorations && showArqmaLogo
        z: parent.z + 1

        Image {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 11
            source: "../images/titlebarLogo.png"
        }
    }

    Label {
        id: titleLabel
        visible: !showArqmaLogo && customDecorations && titleBar.title !== ''
        anchors.centerIn: parent
        fontSize: 18
        text: titleBar.title
        z: parent.z + 1
    }

    // collapse left panel
    Rectangle {
        id: goToBasicVersionButton
        property bool containsMouse: titleBar.mouseX >= x && titleBar.mouseX <= x + width
        property bool checked: false
        anchors.top: parent.top
        anchors.left: parent.left
        color:  "transparent"
        height: titleBar.height
        width: height
        visible: isMobile
        z: parent.z + 2

        Image {
            width: 14
            height: 14
            anchors.centerIn: parent
            source: "../images/expand.png"
        }

        MouseArea {
            id: basicMouseArea
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onEntered: goToBasicVersionButton.color = "#262626";
            onExited: goToBasicVersionButton.color = "transparent";
            onClicked: {
                releaseFocus()
                parent.checked = !parent.checked
                titleBar.goToBasicVersion(leftPanel.visible)
            }
        }
    }

    Row {
        id: row
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: parent.customDecorations
        z: parent.z + 2

        Rectangle {
            id: minimizeButton
            visible: showMinimizeButton
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 42
            color: "transparent"

            Image {
                anchors.centerIn: parent
                source: "../images/minimize.png"
            }

            MouseArea {
                id: minimizeArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: minimizeButton.color = "#262626";
                onExited: minimizeButton.color = "transparent";
                onClicked: minimizeClicked();
            }
        }

        Rectangle {
            id: maximizeButton
            visible: showMaximizeButton
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 42
            color: "transparent";

            Image {
                anchors.centerIn: parent
                height: 16
                width: 16
                source: appWindow.visibility === Window.FullScreen ?  "../images/backToWindowIcon.png" :
                                                                      "../images/fullscreen.png"
            }

            MouseArea {
                id: maximizeArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: maximizeButton.color = "#262626";
                onExited: maximizeButton.color = "transparent";
                onClicked: maximizeClicked();
            }
        }

        Rectangle {
            id: closeButton
            visible: showCloseButton
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 42
            color: containsMouse ? "#E04343" : "#00000000"

            Image {
                anchors.centerIn: parent
                width: 16
                height: 16
                source: "../images/close.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: closeClicked();
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: closeButton.color = "#262626";
                onExited: closeButton.color = "transparent";
            }
        }
    }

    // window borders
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        height: 1
        color: "#2F2F2F"
        z: parent.z + 1
    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        visible: titleBar.small
        height: 1
        color: "#2F2F2F"
        z: parent.z + 1
    }
}
