import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Wayland

import qs.config


PanelWindow {
  id: nativeBar

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "quickshell:bar"

  anchors {
    top: true
    left: true
    right: true
  }
  
  margins {
    top: 8
    left: 8
    right: 8
  }

  color: "transparent"
  implicitHeight: Theme.barHeight

  Rectangle {
    anchors.fill: parent
    color: Theme.surface
    radius: Theme.barRadius
  }
}
