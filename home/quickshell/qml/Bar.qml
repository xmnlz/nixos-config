//@ pragma UseQApplication
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray


PanelWindow {
  id: bar

  anchors {
    top: true
    right: true
    left: true
  }

  implicitHeight: 30
  color: "#1a1b26"

  RowLayout {

    Repeater {
      model: SystemTray.items

      delegate: Item {
        width: 24
        height: 24

        IconImage {
          id: trayIcon
          width: 16
          height: 16
          smooth: false
          asynchronous: true
          // backer.fillMode: Image.PreserveAspectFit
          source: modelData?.icon;
        }

        MouseArea {
          id: trayMouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
          onClicked: (mouse) => {
            if (!modelData) return;

            if (mouse.button === Qt.LeftButton) {
              modelData.activate()
            } else if (mouse.button === Qt.RightButton) {
              if (modelData.hasMenu) {
                modelData.display(bar, mouse.x, mouse.y)
              }
            }
          }
        }
      }
    }
  }
}

