import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.etc

Item {
  id: root

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row

    Repeater {
      model: Hyprland.workspaces
      delegate: Item {
        id: workspaceItem

        required property HyprlandWorkspace modelData
        readonly property bool focused: modelData.focused

        implicitHeight: 28
        implicitWidth: 28

        Rectangle {
          anchors.fill: parent

          radius: Theme.rounding
          color: workspaceItem.focused ? Theme.active : "transparent"

          Text {
            anchors.centerIn: parent

            text: workspaceItem.modelData.id
            color: workspaceItem.focused ? Theme.base : Theme.text

            font {
              pointSize: Theme.fontSize
              family: Theme.fontFamily
              bold: true
            }
          }
        }
      }
    }
  }
}
