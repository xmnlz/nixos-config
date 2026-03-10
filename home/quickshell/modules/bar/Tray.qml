pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.modules

Item {
  id: root
  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  // ── icon row ────────────────────────────────────────────
  Row {
    id: layout
    spacing: 10

    Repeater {
      model: SystemTray.items

      delegate: Item {
        id: trayItem
        required property SystemTrayItem modelData

        implicitWidth: 20
        implicitHeight: 20

        // ── tray icon ────────────────────────────────
        IconImage {
          anchors.fill: parent
          asynchronous: true
          source: {
            let icon = trayItem.modelData.icon
            if (icon.includes("?path=")) {
              const [name, path] = icon.split("?path=")
              icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`
            }
            return icon
          }
        }

        QsMenuOpener {
          id: menuOpener
          menu: trayItem.modelData.menu
        }

        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
          cursorShape: Qt.PointingHandCursor
          onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
              trayItem.modelData.activate()
            } else if (mouse.button === Qt.MiddleButton) {
              trayItem.modelData.secondaryActivate()
            } else if (mouse.button === Qt.RightButton) {
              menuLoader.capturedX = trayItem.mapToItem(null, 0, 0).x
              menuLoader.capturedY = trayItem.mapToItem(null, 0, 0).y
              menuLoader.active = !menuLoader.active
            }
        }

        // ── menu popup ───────────────────────────────
        LazyLoader {
          id: menuLoader
          active: false
          property real capturedX: 0
          property real capturedY: 0

          PanelWindow {
            id: menuWindow
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "qs:traymenu"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            exclusionMode: ExclusionMode.Ignore
            anchors { top: true; left: true; right: true; bottom: true }

            mask: Region {
              x: menu.x; y: menu.y
              width: menu.width; height: menu.height
            }

            // click outside = close
            MouseArea {
              anchors.fill: parent
              onClicked: menuLoader.active = false
            }

            // ── menu card ────────────────────────
            Rectangle {
              id: menu

              // clamped position
              x: (menuLoader.capturedX + width > menuWindow.screen.width - 10)
                 ? Math.max(10, menuLoader.capturedX + trayItem.implicitWidth - width)
                 : Math.max(10, menuLoader.capturedX)
              y: (menuLoader.capturedY + trayItem.implicitHeight + 6 + height > menuWindow.screen.height - 10)
                 ? Math.max(10, menuLoader.capturedY - height - 6)
                 : menuLoader.capturedY + trayItem.implicitHeight + 6

              width: items.width + 16
              height: items.height + 16
              radius: Appearance.rounding.medium
              color: Appearance.colors.m3surface_container_high

              // entrance animation
              opacity: 0
              scale: 0.92
              Component.onCompleted: anim.start()

              ParallelAnimation {
                id: anim
                NumberAnimation {
                  target: menu; property: "opacity"
                  from: 0; to: 1
                  duration: Appearance.animation.fast
                  easing.type: Appearance.animation.easing
                }

                NumberAnimation {
                  target: menu; property: "scale"
                  from: 0.92; to: 1
                  duration: Appearance.animation.fast
                  easing.type: Appearance.animation.easing
                }
              }

              Column {
                id: items
                x: 8; y: 8
                spacing: 2

                Repeater {
                  model: menuOpener.children

                  delegate: Item {
                    id: menuItem
                    required property QsMenuEntry modelData

                    width: 200
                    height: menuItem.modelData.isSeparator
                      ? 1
                      : itemRow.implicitHeight + 8

                    // hover bg
                    Rectangle {
                      anchors.fill: parent
                      radius: Appearance.rounding.small
                      color: menuItem.modelData.isSeparator
                        ? Appearance.colors.m3outline_variant
                        : hover.containsMouse
                          ? Appearance.colors.m3surface_container_highest
                          : "transparent"

                      Behavior on color {
                        ColorAnimation {
                          duration: Appearance.animation.fast
                          easing.type: Appearance.animation.easing
                        }
                      }
                    }

                    // icon + label
                    Row {
                      id: itemRow
                      visible: !menuItem.modelData.isSeparator
                      anchors.verticalCenter: parent.verticalCenter
                      x: 8; spacing: 8

                      IconImage {
                        visible: menuItem.modelData.icon !== ""
                        source: menuItem.modelData.icon
                        width: 14; height: 14
                        anchors.verticalCenter: parent.verticalCenter
                      }

                      Text {
                        text: menuItem.modelData.text
                        color: Appearance.colors.m3on_surface
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                      }
                    }

                    MouseArea {
                      id: hover
                      anchors.fill: parent
                      hoverEnabled: true
                      enabled: !menuItem.modelData.isSeparator
                      cursorShape: Qt.PointingHandCursor
                      onClicked: {
                        if (!menuItem.modelData.hasChildren)
                          menuItem.modelData.triggered()
                        menuLoader.active = false
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
}
