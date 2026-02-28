import Quickshell
import QtQuick
import Quickshell.Services.SystemTray

PanelWindow {
  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 30
  color: "#1a1b26"

  Row {
    spacing: 12
    anchors.verticalCenter: parent.verticalCenter

    // left side text to verify
    Text { text: "My Bar" }

    // a flexible space
    Item { Layout.fillWidth: true }

    // system tray area
    SystemTray {
        id: tray
    }

    // clock example
    Text {
        text: Qt.formatTime(new Date(), "hh:mm")
    }
  }

  Text {
    anchors.centerIn: parent
    text: "My first bar"
    color: "#a9b1d6"
    font.pixelSize: 14
  }
}
