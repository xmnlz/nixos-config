import QtQuick

import qs.etc

Item {
  id: root

  // same API surface you’d expect from an icon
  property string name: ""        // Material symbol name, e.g. "volume_up"
  property color color: "white"
  property real fill: 0.0         // 0.0 = outline, 1.0 = filled (depending on font)
  // property int grade: Colours.light ? 0 : -25

  // allow size control from outside
  property real pointSize: Theme.iconSize

  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    anchors.centerIn: parent

    text: root.name
    color: root.color

    font.family: Theme.iconFontFamily
    font.pointSize: root.pointSize

    // variable font axes for Material Symbols
    font.variableAxes: ({
        FILL: root.fill.toFixed(1),
        GRAD: 0,
        opsz: fontInfo.pixelSize,
        wght: fontInfo.weight
      })
  }
}
