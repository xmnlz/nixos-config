import QtQuick
import qs.modules

Item {
  id: root
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  // visible: Bluetooth.icon !== ""

  Text {
    id: icon
    text: "bluetooth_disabled"
    font.family: "Material Symbols Rounded"
    font.pixelSize: 20
    // color: Bluetooth.activeDevice
    //   ? Appearance.colors.m3primary
    //   : Appearance.colors.m3on_surface_variant
    //
    color: Appearance.colors.m3on_surface_variant

    Behavior on color {
      ColorAnimation {
        duration: Appearance.animation.fast
        easing.type: Appearance.animation.easing
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
  }
}
