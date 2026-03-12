import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules
import qs.services

Item {
  id: root
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: Network.icon
    font.family: "Material Symbols Rounded"
    font.pixelSize: 20
    color: Network.connected
      ? Appearance.colors.m3on_background
      : Appearance.colors.m3on_surface_variant
    renderType: Text.NativeRendering
    Behavior on color {
      ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
    }
  }

  MouseArea {
    id: hover
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
  }

  // ── tooltip ───────────────────────────────────────────
  LazyLoader {
    active: hover.containsMouse

    PanelWindow {
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
        x: Math.min(pos.x + root.width / 2 - width / 2, screen.width - width - 10)
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

          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Network.label
            font.pixelSize: 13
            font.bold: true
            color: Appearance.colors.m3on_surface
            renderType: Text.NativeRendering
          }

          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: Network.connected && !Network.ethernet
            text: Network.strength + "% signal"
            font.pixelSize: 11
            color: Appearance.colors.m3on_surface_variant
            renderType: Text.NativeRendering
          }
        }
      }
    }
  }
}
