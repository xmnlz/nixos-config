import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.modules

PanelWindow {
  id: root

  anchors {
    top: true
    left: true
    right: true
  }

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: 'qs:bar'

  color: "transparent"

  implicitHeight: 36

  Rectangle {
    anchors.fill: parent
    color: Appearance.colors.m3background 
  }


  // LEFT PART
  Row {
    id: barLeft
    anchors.left: parent.left
    anchors.leftMargin: 40
    anchors.verticalCenter: parent.verticalCenter

    DateTime {
      anchors.verticalCenter: parent.verticalCenter
    }
    // your left widgets here
  }

  // CENTER PART
  Row {
    id: barCenter
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    Workspaces {
      id: workspace
    }
  }

  Row {
    id: barRight
    anchors.right: parent.right
    anchors.rightMargin: 40
    anchors.verticalCenter: parent.verticalCenter
    spacing: 16

    Tray {
      anchors.verticalCenter: parent.verticalCenter
    }

    BatteryIndicator {
      anchors.verticalCenter: parent.verticalCenter
    }

    BluetoothIndicator {
      anchors.verticalCenter: parent.verticalCenter
    }

    NetworkIndicator {
      anchors.verticalCenter: parent.verticalCenter
    }

    NotificationIndicator {
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
