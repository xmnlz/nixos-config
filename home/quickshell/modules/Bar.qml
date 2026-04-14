import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

import qs.components
import qs.etc

Scope {
  id: root
  Variants {
    model: Quickshell.screens
    PanelWindow {
      property var modelData
      screen: modelData
      implicitHeight: 46
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }

      margins {
        top: 8
        right: 8
        left: 8
      }

      Rectangle {
        id: bar
        anchors.fill: parent
        radius: 12
        color: Theme.base

        // LEFT — implicit size flows up from BarBlock children
        RowLayout {
          id: leftSection
          anchors {
            left: parent.left
            leftMargin: 12
            verticalCenter: parent.verticalCenter
          }
          spacing: 8

          BarBlock {
            Workspaces {
              anchors.centerIn: parent
            }
          }
        }

        // CENTER — truly centered, independent of side widths
        RowLayout {
          anchors.centerIn: parent
          spacing: 8

          BarBlock {
            Clock {
              anchors.centerIn: parent
            }
          }
        }

        // RIGHT — implicit size flows up from BarBlock children
        RowLayout {
          id: rightSection

          anchors {
            right: parent.right
            rightMargin: 12
            verticalCenter: parent.verticalCenter
          }
          spacing: 8

          BarBlock {
            // show the tray only we have anything to show 
            visible: SystemTray.items.values.length >= 1

            SystemTray {
              anchors.centerIn: parent
            }
          }

          BarBlock {
            Battery {
              anchors.centerIn: parent
            }
          }
        }
      }
    }
  }
}
