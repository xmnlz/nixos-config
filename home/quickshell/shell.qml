// import QtQuick
// import QtQuick.Layouts
// import Quickshell
// import Quickshell.Services.SystemTray
//
// PanelWindow {
//     anchors {
//       top: true
//       right: true
//       left: true
//     }
//     implicitHeight: 30
//     color: "#1a1b26"
//
//     RowLayout {
//         anchors.fill: parent
//         anchors.margins: 6
//         spacing: 10
//
//         Item { Layout.fillWidth: true }
//
//         Repeater {
//             model: SystemTray.items
//
//             delegate: Item {
//                 width: 20
//                 height: 20
//
//                 Image {
//                     anchors.fill: parent
//                     source: modelData.icon
//                     fillMode: Image.PreserveAspectFit
//                 }
//
//                 MouseArea {
//                     anchors.fill: parent
//                     acceptedButtons: Qt.LeftButton | Qt.RightButton
//                     onClicked: (mouse) => {
//                         if (mouse.button === Qt.RightButton && modelData.hasMenu)
//                             modelData.display(tray, mouseX, mouseY)
//                         else
//                             modelData.activate()
//                     }
//                 }
//             }
//         }
//
//         Text {
//             id: clock
//             text: Qt.formatTime(new Date(), "hh:mm")
//
//             Timer {
//                 interval: 1000
//                 running: true
//                 repeat: true
//                 onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
//             }
//         }
//     }
// }
//
//
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

RowLayout {
    id: trayRoot
    
    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            id: itemContainer
            width: 32
            height: 32
            color: mouseArea.containsMouse ? "white" : "transparent"

            Image {
                anchors.centerIn: parent
                width: 24
                height: 24
                source: Quickshell.iconPath(modelData.icon, "application-x-executable")
            }

            // This handles the application's "modal" context menu
            QsMenuAnchor {
                id: appMenu
                // Link to the SNI item's menu handle [3]
                menu: modelData.menu 
                placement: Placement.Bottom // Where the menu appears
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                hoverEnabled: true

                onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        // Standard app activation (left click) [3]
                        modelData.activate(); 
                    } else if (mouse.button === Qt.RightButton) {
                        // Open the app's native context menu [3]
                        appMenu.open(); 
                    }
                }
            }
        }
    }
}
