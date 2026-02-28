import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#1a1b26"

    // This just *activates* the service
    SystemTray { id: tray }

    Row {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 10

        Text { text: "My Bar" }

        Item { Layout.fillWidth: true }  // spacer if using RowLayout

        // Show tray icons
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
            text: Qt.formatTime(new Date(), "hh:mm")
        }
    }
}
