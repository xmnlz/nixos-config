import QtQuick
import Quickshell.Hyprland

import qs.modules

Item {
  id: root
  height: 25
  width: pills.implicitWidth + 20

  Rectangle {
    id: bgRect
    // opacity: !Preferences.bar.keepOpaque && !Hyprland.currentWorkspace.hasTilingWindow() ? 0 : 1
    Behavior on opacity { NumberAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing } }

    anchors.fill: parent
    color: Appearance.colors.m3surface_container
    radius: 20
  }

  Row {
    id: pills
    anchors.centerIn: parent
    spacing: 10

    Repeater {
      model: Hyprland.workspaces

      delegate: Rectangle {
        required property var modelData

        property bool focused : modelData.id === Hyprland.focusedWorkspace?.id

        id: pill
        height: 10
        radius: 20
        width: focused ? 20: 10
        anchors.verticalCenter: parent.verticalCenter
        opacity: focused ? 1.0 : 0.4
        color: focused ? Appearance.colors.m3primary : Appearance.colors.m3on_surface

        Behavior on width { NumberAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing } }
        Behavior on opacity { NumberAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing } }
        Behavior on color { ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing } }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Hyprland.dispatch(`workspace ${pill.modelData.id}`)
        }
      }
    }
  }
}
