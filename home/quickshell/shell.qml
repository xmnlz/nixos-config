//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication
import QtQuick
import Quickshell

import qs.modules

ShellRoot {
  Variants {
    model: Quickshell.screens
    
    Bar {
      required property var modelData
      screen: modelData
      
      // Optional: Customize per-monitor
      // showMediaControls: screen.primary
    }
  }
}
