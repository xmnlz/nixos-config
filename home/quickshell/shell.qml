import Quickshell
import QtQuick

FloatingWindow {
  visible: true
  width: 200
  height: 200

  Text {
    anchors.centerIn: parent
    text: "Hello, Quickshell!"
    color: "#0d0d0d"
    font.pixelSize: 20
  }
}
