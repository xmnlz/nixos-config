pragma Singleton
import QtQuick

QtObject {
  id: theme

  // Backgrounds
  readonly property color background: "#1c1c1e"        // Main bar background
  readonly property color surface: "#2c2c2e"           // Elevated elements
  readonly property color surfaceHover: "#3a3a3c"      // Hover state
  readonly property color surfaceActive: "#48484a"     // Active/pressed state
  
  // Borders & Separators
  readonly property color border: "#48484a"            // Subtle borders
  readonly property color separator: "#38383a"         // Section dividers
  
  // Text
  readonly property color textPrimary: "#ffffff"       // Main text
  readonly property color textSecondary: "#98989d"     // Secondary text
  readonly property color textTertiary: "#636366"      // Disabled/tertiary
  
  // Accent Colors
  readonly property color accentBlue: "#0a84ff"        // Primary accent
  readonly property color accentGreen: "#30d158"       // Active/success
  readonly property color accentRed: "#ff453a"         // Urgent/error
  readonly property color accentOrange: "#ff9f0a"      // Warning
  readonly property color accentPurple: "#bf5af2"      // Alternative accent
  
  // DIMENSIONS
  
  // Bar
  readonly property int barHeight: 34
  readonly property int barPaddingHorizontal: 12
  readonly property int barPaddingVertical: 4
  readonly property int barRadius: 0                   // 0 for flat edges, 10 for rounded
  readonly property int barMarginTop: 0                // Distance from screen edge
  readonly property int barMarginHorizontal: 0         // Side margins (0 = full width)
  
  // Spacing
  readonly property int spacingSmall: 6
  readonly property int spacingMedium: 10
  readonly property int spacingLarge: 16
  readonly property int spacingSection: 20             // Between major sections
  
  // Icons & Components
  readonly property int iconSizeTray: 22               // System tray icons
  readonly property int iconSizeIndicator: 18          // System indicators
  readonly property int iconSizeWorkspace: 16          // Workspace indicators
  readonly property int componentRadius: 6             // Button/component rounding
  readonly property int componentPadding: 8            // Internal padding
  
  // Typography
  readonly property int fontSizeDefault: 13
  readonly property int fontSizeSmall: 11
  readonly property int fontSizeLarge: 14
  readonly property string fontFamily: "SF Pro Text"   // Falls back to system default
  
  // ANIMATIONS
  readonly property int animationDuration: 250         // Standard transitions
  readonly property int animationDurationFast: 150     // Quick transitions
  readonly property int animationDurationSlow: 350     // Slow/dramatic transitions
  
  // Easing curve (use with NumberAnimation/ColorAnimation)
  readonly property int easingType: Easing.OutCubic    // Smooth Apple-like easing
  
  // EFFECTS
  readonly property real hoverScale: 1.05              // Scale on hover
  readonly property real pressScale: 0.95              // Scale on press
  readonly property real opacityDisabled: 0.4          // Disabled elements
  readonly property real opacitySecondary: 0.7         // Secondary elements
  
  // HELPER FUNCTIONS
  // Mix two colors with alpha blending
  function mixColors(color1, color2, ratio) {
      return Qt.tint(color1, Qt.rgba(color2.r, color2.g, color2.b, ratio))
  }
  
  // Create a semi-transparent version of a color
  function withOpacity(color, opacity) {
      return Qt.rgba(color.r, color.g, color.b, opacity)
  }
}
