import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

import "../config"

PanelWindow {
  id: bar
  
  property bool showWorkspaces: true
  property bool showWindowTitle: true
  property bool showSystemTray: true
  property bool showClock: true
  
  // WINDOW SETUP
  
  anchors {
    top: true
    left: true
    right: true
  }
  
  margins {
    top: Theme.barMarginTop
    left: Theme.barMarginHorizontal
    right: Theme.barMarginHorizontal
  }
  
  height: Theme.barHeight
  color: Theme.background
  
  // Wayland layershell configuration
  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "quickshell-bar"
  
  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: Theme.barPaddingHorizontal
    anchors.rightMargin: Theme.barPaddingHorizontal
    spacing: Theme.spacingSection
    
    // Workspaces
    
    RowLayout {
      spacing: Theme.spacingSmall
      visible: bar.showWorkspaces
      
      Repeater {
        model: Hyprland.workspaces
        
        delegate: Rectangle {
          required property var modelData
          
          id: workspaceButton
          
          implicitWidth: Theme.iconSizeWorkspace + Theme.componentPadding * 2
          implicitHeight: Theme.barHeight - Theme.barPaddingVertical * 2
          
          radius: Theme.componentRadius
          
          // Active workspace gets accent color
          property bool isActive: modelData.id === Hyprland.focusedWorkspace?.id
          property bool hasWindows: modelData.toplevels.length > 0
          
          color: isActive 
            ? Theme.accentBlue 
            : (hasWindows ? Theme.surface : "transparent")
          
          // Smooth color transitions
          Behavior on color {
            ColorAnimation { 
              duration: Theme.animationDuration
              easing.type: Theme.easingType
            }
          }
          
          // Workspace number
          Text {
            anchors.centerIn: parent
            text: workspaceButton.modelData.id
            color: workspaceButton.isActive 
              ? Theme.textPrimary 
              : (workspaceButton.hasWindows ? Theme.textSecondary : Theme.textTertiary)
            font.pixelSize: Theme.fontSizeSmall
            font.family: Theme.fontFamily
            font.weight: workspaceButton.isActive ? Font.DemiBold : Font.Normal
            
            Behavior on color {
              ColorAnimation { 
                duration: Theme.animationDuration
                easing.type: Theme.easingType
              }
            }
          }
          
          // Click to switch workspace
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            
            onEntered: {
              if (!workspaceButton.isActive) {
                workspaceButton.color = Theme.surfaceHover
              }
            }
            
            onExited: {
              // Color will return via binding
            }
            
            onClicked: {
              Hyprland.dispatch(`workspace ${workspaceButton.modelData.id}`)
            }
          }
        }
      }
    }
    
    // ====================================
    // LEFT-CENTER: Window Title
    // ====================================
    
    Text {
      visible: bar.showWindowTitle
      Layout.fillWidth: true
      Layout.maximumWidth: 400
      
      text: Hyprland.activeToplevel?.title ?? "Quickshell"
      color: Theme.textSecondary
      font.pixelSize: Theme.fontSizeDefault
      font.family: Theme.fontFamily
      
      elide: Text.ElideRight
      
      // Smooth text opacity transition when title changes
      Behavior on opacity {
        NumberAnimation { 
          duration: Theme.animationDurationFast
          easing.type: Theme.easingType
        }
      }
    }
    
    // ====================================
    // SPACER (pushes right section to the right)
    // ====================================
    
    Item { Layout.fillWidth: true }
    
    // ====================================
    // RIGHT SECTION: System Tray
    // ====================================
    
    // ----------------------------------
    // System Tray (HIGH-RES ICONS!)
    // ----------------------------------
    
    RowLayout {
      visible: bar.showSystemTray
      spacing: Theme.spacingMedium
      
      Repeater {
        model: SystemTray.items
        
        delegate: Rectangle {
          required property var modelData
          
          id: trayItem
          
          implicitWidth: Theme.iconSizeTray + Theme.componentPadding
          implicitHeight: Theme.iconSizeTray + Theme.componentPadding
          
          radius: Theme.componentRadius
          color: trayMouseArea.containsMouse ? Theme.surfaceHover : "transparent"
          
          // Smooth hover transition
          Behavior on color {
            ColorAnimation { 
              duration: Theme.animationDurationFast
              easing.type: Theme.easingType
            }
          }
          
          // HIGH-RESOLUTION ICON with mipmap filtering
          IconImage {
            id: trayIcon
            anchors.centerIn: parent
            
            source: trayItem.modelData.icon
            implicitSize: Theme.iconSizeTray
            
            // CRITICAL: Enable mipmap for high-quality scaling
            mipmap: true
            asynchronous: true
            
            // Subtle scale effect on hover
            scale: trayMouseArea.containsMouse ? Theme.hoverScale : 1.0
            
            Behavior on scale {
              NumberAnimation {
                duration: Theme.animationDurationFast
                easing.type: Theme.easingType
              }
            }
          }
          
          // Status indicator for "NeedsAttention"
          Rectangle {
            visible: trayItem.modelData.status === "NeedsAttention"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 2
            
            width: 6
            height: 6
            radius: 3
            
            color: Theme.accentRed
          }
          
          MouseArea {
            id: trayMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
            
            onClicked: (mouse) => {
              if (mouse.button === Qt.LeftButton) {
                trayItem.modelData.activate()
              } else if (mouse.button === Qt.RightButton) {
                // Show context menu
                trayItem.modelData.display(bar, mouse.x, mouse.y)
              } else if (mouse.button === Qt.MiddleButton) {
                trayItem.modelData.secondaryActivate()
              }
            }
            
            onWheel: (wheel) => {
              trayItem.modelData.scroll(wheel.angleDelta.y, false)
            }
            
            // Tooltip using Qt Quick Controls
            ToolTip.visible: containsMouse
            ToolTip.text: trayItem.modelData.tooltipTitle || trayItem.modelData.title
            ToolTip.delay: 400
          }
        }
      }
    }
    
    // ----------------------------------
    // Separator before clock
    // ----------------------------------
    
    Rectangle {
      visible: bar.showClock
      width: 1
      height: Theme.barHeight - Theme.barPaddingVertical * 4
      color: Theme.separator
    }
    
    // ----------------------------------
    // Clock
    // ----------------------------------
    
    Text {
      visible: bar.showClock
      
      id: clockText
      text: Qt.formatDateTime(new Date(), "h:mm AP")
      color: Theme.textPrimary
      font.pixelSize: Theme.fontSizeDefault
      font.family: Theme.fontFamily
      font.weight: Font.Medium
      
      // Update every minute
      Timer {
        interval: 60000 // 60 seconds
        running: true
        repeat: true
        triggeredOnStart: true
        
        onTriggered: {
          clockText.text = Qt.formatDateTime(new Date(), "h:mm AP")
        }
      }
    }
  }
}
