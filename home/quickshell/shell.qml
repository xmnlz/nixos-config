import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#1a1b26"

    // The service (data provider)
    SystemTray {
        id: tray
    }

    Row {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 12

        Text {
            text: "My Bar"
            color: "#a9b1d6"
        }

        Item { width: 1; Layout.fillWidth: true }

        // Render tray items
        Repeater {
            model: tray.items

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
                    onClicked: modelData.activate()
                }
            }
        }

        Text {
            color: "#a9b1d6"
            text: Qt.formatTime(new Date(), "hh:mm")
        }
    }
}
