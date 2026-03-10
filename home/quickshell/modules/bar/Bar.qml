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

  implicitHeight: 44

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
    width: childrenRect.width
    height: childrenRect.height

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
    width: workspace.width
    height: workspace.height

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

    Battery {
      anchors.verticalCenter: parent.verticalCenter
    }

    Tray {
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
