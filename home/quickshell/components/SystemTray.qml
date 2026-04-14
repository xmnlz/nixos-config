import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.etc

Item {
  id: root
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  Row {
    id: row
    spacing: 6

    Repeater {
      model: SystemTray.items

      delegate: Rectangle {
        id: trayItem
        required property SystemTrayItem modelData

        width: 18
        height: 18
        color: "transparent"

        QsMenuAnchor {
          id: menu
          menu: trayItem.modelData.menu
          anchor.window: trayItem.QsWindow.window   // ← required for open() to work
          anchor.rect: Qt.rect(trayItem.mapToItem(null, 0, 0).x, trayItem.mapToItem(null, 0, 0).y, trayItem.width, trayItem.height)
        }

        IconImage {
          source: Helper.getTrayIcon(trayItem.modelData.id, trayItem.modelData.icon)
          anchors.fill: parent
          asynchronous: true
          mipmap: true
        }

        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

          onPressed: mouse => {
            if (mouse.button === Qt.LeftButton) {
              trayItem.modelData.activate();
            } else if (mouse.button === Qt.MiddleButton) {
              trayItem.modelData.secondaryActivate();
            } else if (mouse.button === Qt.RightButton) {
              menu.open();
              // menu.open(trayItem.mapToGlobal(0, trayItem.height));
            }
          }
        }
      }
    }
  }
}
