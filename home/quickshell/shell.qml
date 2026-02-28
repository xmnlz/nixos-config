import Quickshell
import QtQuick

PanelWindow {
  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHight: 30
  color: "#1a1b26"

  Text {
    anchors.centerIn: parent
    text: "My first bar"
    color: "#a9b1d6"
    font.pixelSize: 14
  }
}
