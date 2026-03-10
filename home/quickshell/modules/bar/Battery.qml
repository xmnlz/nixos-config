import QtQuick
import Quickshell.Services.UPower
import qs.modules

Item {
  id: root

  // grab the first real battery directly from UPower
  readonly property var battery: UPower.devices.values.find(d => d.isLaptopBattery) ?? null
  readonly property real pct: battery ? battery.percentage * 100 : 0
  readonly property bool charging: !UPower.onBattery

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight
  visible: battery !== null

  readonly property color batteryColor: {
    if (charging) return Appearance.colors.m3primary
    if (pct < 20) return Appearance.colors.m3error
    if (pct < 50) return Appearance.colors.m3secondary
    return Appearance.colors.m3on_background
  }

  readonly property string batteryIcon: {
    if (charging) return "bolt"
    if (pct < 10) return "battery_0_bar"
    if (pct < 20) return "battery_1_bar"
    if (pct < 40) return "battery_2_bar"
    if (pct < 60) return "battery_4_bar"
    if (pct < 80) return "battery_5_bar"
    return "battery_full"
  }

  Row {
    id: row
    spacing: 4
    anchors.verticalCenter: parent.verticalCenter

    Text {
      text: root.batteryIcon
      font.family: "Material Symbols Rounded"
      font.pixelSize: 20
      color: root.batteryColor
      anchors.verticalCenter: parent.verticalCenter

      Behavior on color {
        ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
      }
    }

    Text {
      text: Math.floor(root.pct) + "%"
      font.pixelSize: 12
      color: root.batteryColor
      anchors.verticalCenter: parent.verticalCenter

      Behavior on color {
        ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
      }
    }
  }
}
