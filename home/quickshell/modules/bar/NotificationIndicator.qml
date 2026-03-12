pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules
import qs.services

Item {
  id: root
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  Row {
    id: row
    spacing: 4
    anchors.verticalCenter: parent.verticalCenter

    // ── bell icon ────────────────────────────────────────
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: "notifications"
      font.family: "Material Symbols Rounded"
      font.pixelSize: 20
      color: Notification.count > 0
        ? Appearance.colors.m3on_background
        : Appearance.colors.m3on_surface_variant

      Behavior on color {
        ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
      }
    }

    // ── badge ────────────────────────────────────────────
    Rectangle {
      visible: Notification.count > 0
      anchors.verticalCenter: parent.verticalCenter
      width: badge.implicitWidth + 6
      height: 16
      radius: 8
      color: Appearance.colors.m3primary

      Text {
        id: badge
        anchors.centerIn: parent
        text: Notification.count > 99 ? "99+" : Notification.count
        font.pixelSize: 9
        font.bold: true
        color: Appearance.colors.m3on_primary
      }
    }
  }

  // ── click to open panel ──────────────────────────────
  MouseArea {
    id: hover
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: panelLoader.active = !panelLoader.active
  }

  // ── notification panel ───────────────────────────────
  LazyLoader {
    id: panelLoader
    active: false

    PanelWindow {
      id: panelWindow
      color: "transparent"
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.namespace: "qs:notifpanel"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      exclusionMode: ExclusionMode.Ignore
      anchors { top: true; left: true; right: true; bottom: true }

      mask: Region {
        x: panel.x; y: panel.y
        width: panel.width; height: panel.height
      }

      // click outside closes
      MouseArea {
        anchors.fill: parent
        onClicked: panelLoader.active = false
      }

      // ── panel card ──────────────────────────────────
      Rectangle {
        id: panel

        readonly property point pos: root.mapToItem(null, 0, 0)
        readonly property real rightEdge: panelWindow.screen.width - 10

        width: 340
        x: Math.min(pos.x + root.width / 2 - width / 2, rightEdge - width)
        y: pos.y + root.height + 8

        height: Math.min(inner.implicitHeight + 16, 480)
        radius: Appearance.rounding.medium
        color: Appearance.colors.m3surface_container_high
        clip: true

        opacity: 0
        scale: 0.94
        Component.onCompleted: entrance.start()

        ParallelAnimation {
          id: entrance
          NumberAnimation { target: panel; property: "opacity"; from: 0; to: 1; duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
          NumberAnimation { target: panel; property: "scale"; from: 0.94; to: 1; duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
        }

        Column {
          id: inner
          anchors { left: parent.left; right: parent.right; top: parent.top; margins: 8 }
          spacing: 6

          // ── header ──────────────────────────────────
          Row {
            width: parent.width
            height: 32

            Text {
              anchors.verticalCenter: parent.verticalCenter
              text: "Notifications"
              font.pixelSize: 13
              font.bold: true
              color: Appearance.colors.m3on_surface
              renderType: Text.NativeRendering
            }

            Item { width: parent.width - clearBtn.width - 120; height: 1 }

            // clear all button
            Rectangle {
              id: clearBtn
              anchors.verticalCenter: parent.verticalCenter
              width: clearRow.implicitWidth + 12
              height: 24
              radius: Appearance.rounding.small
              color: clearMouse.containsMouse
                ? Appearance.colors.m3surface_container_highest
                : "transparent"
              visible: Notification.count > 0
              Behavior on color {
                ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
              }

              Row {
                id: clearRow
                anchors.centerIn: parent
                spacing: 4
                Text {
                  text: "clear_all"
                  font.family: "Material Symbols Rounded"
                  font.pixelSize: 14
                  color: Appearance.colors.m3on_surface_variant
                  renderType: Text.NativeRendering
                  anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                  text: "Clear all"
                  font.pixelSize: 11
                  color: Appearance.colors.m3on_surface_variant
                  renderType: Text.NativeRendering
                  anchors.verticalCenter: parent.verticalCenter
                }
              }

              MouseArea {
                id: clearMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Notification.clearAll()
              }
            }
          }

          // ── empty state ──────────────────────────────
          Text {
            visible: Notification.count === 0
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: "You're all caught up!"
            font.pixelSize: 12
            color: Appearance.colors.m3on_surface_variant
            renderType: Text.NativeRendering
            topPadding: 8
            bottomPadding: 8
          }

          // ── notification list ────────────────────────
          Column {
            width: parent.width
            spacing: 4

            Repeater {
              model: Notification.notifications

              delegate: Rectangle {
                id: notifItem
                required property var modelData
                required property int index

                width: parent.width
                height: notifCol.implicitHeight + 12
                radius: Appearance.rounding.small
                color: notifMouse.containsMouse
                  ? Appearance.colors.m3surface_container_highest
                  : Appearance.colors.m3surface_container
                Behavior on color {
                  ColorAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
                }

                // urgency accent strip
                Rectangle {
                  width: 3
                  height: parent.height - 8
                  anchors { left: parent.left; leftMargin: 4; verticalCenter: parent.verticalCenter }
                  radius: 2
                  color: notifItem.modelData.urgency === 2
                    ? Appearance.colors.m3error
                    : Appearance.colors.m3primary
                }

                Column {
                  id: notifCol
                  anchors { left: parent.left; right: parent.right; top: parent.top; margins: 10; leftMargin: 14 }
                  spacing: 2

                  // app name
                  Text {
                    width: parent.width
                    text: notifItem.modelData.appName
                    font.pixelSize: 10
                    color: Appearance.colors.m3on_surface_variant
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                  }

                  // summary
                  Text {
                    width: parent.width
                    text: notifItem.modelData.summary
                    font.pixelSize: 12
                    font.bold: true
                    color: Appearance.colors.m3on_surface
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                  }

                  // body
                  Text {
                    visible: notifItem.modelData.body !== ""
                    width: parent.width
                    text: notifItem.modelData.body
                    font.pixelSize: 11
                    color: Appearance.colors.m3on_surface_variant
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                  }
                }

                // dismiss X
                Text {
                  anchors { right: parent.right; top: parent.top; margins: 6 }
                  text: "close"
                  font.family: "Material Symbols Rounded"
                  font.pixelSize: 14
                  color: Appearance.colors.m3on_surface_variant
                  renderType: Text.NativeRendering
                  opacity: notifMouse.containsMouse ? 1 : 0
                  Behavior on opacity {
                    NumberAnimation { duration: Appearance.animation.fast; easing.type: Appearance.animation.easing }
                  }

                  MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Notification.remove(notifItem.modelData)
                  }
                }

                MouseArea {
                  id: notifMouse
                  anchors.fill: parent
                  hoverEnabled: true
                }
              }
            }
          }
        }
      }
    }
  }
}
