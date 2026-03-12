pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.UPower
import qs.modules

Item {
  id: root

  readonly property var battery: UPower.devices.values.find(d => d.isLaptopBattery) ?? null
  readonly property real pct: battery ? battery.percentage * 100 : 0
  readonly property bool charging: !UPower.onBattery

  implicitWidth: 36
  implicitHeight: 36
  visible: battery !== null

  readonly property string stateText: {
    if (!battery) return "Unknown"

    switch (battery.state) {
      case UPowerDeviceState.Charging:        return "Charging"
      case UPowerDeviceState.Discharging:     return "Discharging"
      case UPowerDeviceState.FullyCharged:    return "Fully charged"
      case UPowerDeviceState.PendingCharge:   return "Pending charge"
      case UPowerDeviceState.PendingDischarge:return "Pending discharge"
      case UPowerDeviceState.Empty:           return "Empty"
      default:                                return "Unknown"
    }
  }

  readonly property color arcColor: {
    if (!battery) return Appearance.colors.m3primary

    switch (battery.state) {
      case UPowerDeviceState.FullyCharged:    return Appearance.colors.m3primary
      case UPowerDeviceState.Charging:        return Appearance.colors.m3primary
      case UPowerDeviceState.PendingCharge:   return Appearance.colors.m3primary
      case UPowerDeviceState.Discharging:
        if (pct < 20) return Appearance.colors.m3error
        if (pct < 50) return Appearance.colors.m3secondary
        return Appearance.colors.m3primary
      case UPowerDeviceState.PendingDischarge:return Appearance.colors.m3secondary
      case UPowerDeviceState.Empty:           return Appearance.colors.m3error
      default:                                return Appearance.colors.m3primary
    }
  }

  readonly property string centerIcon: {
    if (!battery) return "battery_unknown"

    switch (battery.state) {
      case UPowerDeviceState.Charging:
      case UPowerDeviceState.PendingCharge:   return "bolt"
      case UPowerDeviceState.FullyCharged:    return "battery_full"
      case UPowerDeviceState.Empty:           return "battery_0_bar"
      default:
        if (pct < 10) return "battery_0_bar"
        if (pct < 20) return "battery_1_bar"
        if (pct < 40) return "battery_2_bar"
        if (pct < 60) return "battery_4_bar"
        if (pct < 80) return "battery_5_bar"
        return "battery_full"
    }
  }

  onPctChanged: canvas.requestPaint()
  onArcColorChanged: canvas.requestPaint()

  // ── ring ─────────────────────────────────────────────
  Canvas {
    id: canvas
    anchors.fill: parent
    Component.onCompleted: requestPaint()

    onPaint: {
      const ctx = getContext("2d")
      const cx = width / 2
      const cy = height / 2
      const r = Math.min(cx, cy) - 3
      const start = -Math.PI / 2
      const end = start + (Math.PI * 2) * (root.pct / 100)
      const track = Appearance.colors.m3surface_container_high
      const fill = root.arcColor

      ctx.reset()

      ctx.beginPath()
      ctx.arc(cx, cy, r, 0, Math.PI * 2)
      ctx.lineWidth = 3
      ctx.strokeStyle = Qt.rgba(track.r, track.g, track.b, track.a)
      ctx.stroke()

      ctx.beginPath()
      ctx.arc(cx, cy, r, start, end)
      ctx.lineWidth = 3
      ctx.strokeStyle = Qt.rgba(fill.r, fill.g, fill.b, fill.a)
      ctx.lineCap = "round"
      ctx.stroke()
    }
  }

  Text {
    anchors.centerIn: parent
    text: root.centerIcon
    font.family: "Material Symbols Rounded"
    font.pixelSize: 16
    color: root.arcColor
    renderType: Text.NativeRendering
    Behavior on color {
      ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
    }
  }

  // ── tooltip ───────────────────────────────────────────
  MouseArea {
    id: hover
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
  }

  LazyLoader {
    active: hover.containsMouse

    PanelWindow {
      id: tooltipWindow
      color: "transparent"
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.namespace: "qs:tooltip"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      exclusionMode: ExclusionMode.Ignore
      anchors { top: true; left: true; right: true; bottom: true }

      mask: Region {
        x: tip.x; y: tip.y
        width: tip.width; height: tip.height
      }

      Rectangle {
        id: tip

        readonly property point pos: root.mapToItem(null, 0, 0)

        x: Math.min(pos.x + root.width / 2 - width / 2, tooltipWindow.screen.width - width - 10)
        y: pos.y + root.height + 6

        width: col.implicitWidth + 16
        height: col.implicitHeight + 12
        radius: Appearance.rounding.small
        color: Appearance.colors.m3surface_container_high

        opacity: 0
        Component.onCompleted: opacity = 1
        Behavior on opacity {
          NumberAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
        }

        Column {
          id: col
          anchors.centerIn: parent
          spacing: 2

          // percentage + state on one line
          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Math.floor(root.pct) + "% · " + root.stateText
            font.pixelSize: 13
            color: Appearance.colors.m3on_surface
          }

          // time remaining if discharging, time to full if charging
          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.battery !== null && (
              root.battery.state === UPowerDeviceState.Charging ||
              root.battery.state === UPowerDeviceState.Discharging
            )
            text: {
              if (!root.battery) return ""

              if (root.battery.state === UPowerDeviceState.Charging) {
                return root.battery.timeToFull > 0
                ? "Full in " + Utils.formatSeconds(root.battery.timeToFull)  
                : "Calculating..."
              }

              return root.battery.timeToEmpty > 0
                ? Utils.formatSeconds(root.battery.timeToEmpty) + " remaining" 
                : "Calculating..."
            }
            font.pixelSize: 11
            color: Appearance.colors.m3on_surface_variant
          }
        }
      }
    }
  }
}
