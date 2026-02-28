import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

PanelWindow {
    anchors {
      top: true
      right: true
      left: true
    }
    implicitHeight: 30
    color: "#1a1b26"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 10

        Item { Layout.fillWidth: true }

        Repeater {
            model: SystemTray.items

            delegate: Item {
                width: 20
                height: 20

                Image {
                    anchors.fill: parent
                    source: modelData.icon
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.RightButton && modelData.hasMenu)
                            modelData.display(tray, mouseX, mouseY)
                        else
                            modelData.activate()
                    }
                }
            }
        }

        Text {
            id: clock
            text: Qt.formatTime(new Date(), "hh:mm")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }
    }
}
