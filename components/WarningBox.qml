import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import "." as ArqmaComponents

Rectangle {
    id: root
    property alias text: content.text
    property alias textColor: content.color
    property int fontSize: 15 * scaleRatio

    Layout.fillWidth: true
    Layout.preferredHeight: warningLayout.height

    color: "#09FFFFFF"
    radius: 4
    border.color: ArqmaComponents.Style.inputBorderColorInActive
    border.width: 1

    signal linkActivated;

    RowLayout {
        id: warningLayout
        spacing: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 33 * scaleRatio
            Layout.preferredWidth: 33 * scaleRatio
            Layout.rightMargin: 12 * scaleRatio
            Layout.leftMargin: 18 * scaleRatio
            Layout.topMargin: 12 * scaleRatio
            Layout.bottomMargin: 12 * scaleRatio
            source: "../images/warning.png"
        }

        TextArea {
            id: content
            Layout.fillWidth: true
            color: ArqmaComponents.Style.defaultFontColor
            font.family: ArqmaComponents.Style.fontRegular.name
            font.pixelSize: root.fontSize
            horizontalAlignment: TextInput.AlignLeft
            selectByMouse: true
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            textMargin: 0
            leftPadding: 4 * scaleRatio
            rightPadding: 18 * scaleRatio
            topPadding: 10 * scaleRatio
            bottomPadding: 10 * scaleRatio
            readOnly: true
            onLinkActivated: root.linkActivated();

            selectionColor: ArqmaComponents.Style.dimmedFontColor
            selectedTextColor: ArqmaComponents.Style.defaultFontColor
        }
    }
}
