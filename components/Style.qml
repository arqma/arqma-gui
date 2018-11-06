pragma Singleton

import QtQuick 2.5

QtObject {
    property QtObject fontMedium: FontLoader { id: _fontMedium; source: "qrc:/fonts/Roboto-Medium.ttf"; }
    property QtObject fontBold: FontLoader { id: _fontBold; source: "qrc:/fonts/Roboto-Bold.ttf"; }
    property QtObject fontLight: FontLoader { id: _fontLight; source: "qrc:/fonts/Roboto-Light.ttf"; }
    property QtObject fontRegular: FontLoader { id: _fontRegular; source: "qrc:/fonts/Roboto-Regular.ttf"; }

    property string grey: "#504C4B"

    property string defaultFontColor: "white"
    property string dimmedFontColor: "#BBBBBB"
    property string inputBoxBackground: "black"
    property string inputBoxBackgroundError: "#FFDDDD"
    property string inputBoxColor: "white"
    property string legacy_placeholderFontColor: "#000C70"
    property string inputBorderColorActive: Qt.rgba(255, 255, 255, 0.38)
    property string inputBorderColorInActive: Qt.rgba(255, 255, 255, 0.32)
    property string inputBorderColorInvalid: Qt.rgba(255, 0, 0, 0.40)

    property string buttonBackgroundColor: "#1216FF"
    property string buttonBackgroundColorHover: "#504C4B"
    property string buttonBackgroundColorDisabled: "#504C4B"
    property string buttonBackgroundColorDisabledHover: "#1216FF"
    property string buttonTextColor: "white"
    property string buttonTextColorDisabled: "black"
    property string dividerColor: "white"
    property real dividerOpacity: 0.20
}
