pragma Singleton
import QtQuick

QtObject {
    id: theme
    
    // ============================================================================
    // MATERIAL DESIGN 3 - COLOR SYSTEM (DARK THEME)
    // ============================================================================
    // NOTE: Material 3 uses "onX" naming (e.g., "onPrimary" = text on primary)
    // but QML interprets "onX" as signal handlers, so we use "textOnX" instead
    
    // === PRIMARY COLORS ===
    readonly property color primary: "#D0BCFF"                    // Primary 80
    readonly property color textOnPrimary: "#381E72"              // Primary 20 - text on primary
    readonly property color primaryContainer: "#4F378B"           // Primary 30
    readonly property color textOnPrimaryContainer: "#EADDFF"     // Primary 90 - text on primary container
    
    // === SECONDARY COLORS ===
    readonly property color secondary: "#CCC2DC"                  // Secondary 80
    readonly property color textOnSecondary: "#332D41"            // Secondary 20
    readonly property color secondaryContainer: "#4A4458"         // Secondary 30
    readonly property color textOnSecondaryContainer: "#E8DEF8"   // Secondary 90
    
    // === TERTIARY COLORS ===
    readonly property color tertiary: "#EFB8C8"                   // Tertiary 80
    readonly property color textOnTertiary: "#492532"             // Tertiary 20
    readonly property color tertiaryContainer: "#633B48"          // Tertiary 30
    readonly property color textOnTertiaryContainer: "#FFD8E4"    // Tertiary 90
    
    // === ERROR COLORS ===
    readonly property color error: "#F2B8B5"                      // Error 80
    readonly property color textOnError: "#601410"                // Error 20
    readonly property color errorContainer: "#8C1D18"             // Error 30
    readonly property color textOnErrorContainer: "#F9DEDC"       // Error 90
    
    // === SURFACE COLORS (Backgrounds) ===
    readonly property color surface: "#1C1B1F"                    // Neutral 10
    readonly property color textOnSurface: "#E6E1E5"              // Neutral 90 - primary text
    readonly property color surfaceVariant: "#49454F"             // Neutral Variant 30
    readonly property color textOnSurfaceVariant: "#CAC4D0"       // Neutral Variant 80 - secondary text
    
    // === SURFACE CONTAINERS (Elevated backgrounds) ===
    readonly property color surfaceContainerLowest: "#0F0D13"     // Elevation 0
    readonly property color surfaceContainerLow: "#1D1B20"        // Elevation 1
    readonly property color surfaceContainer: "#211F26"           // Elevation 2 (menus)
    readonly property color surfaceContainerHigh: "#2B2930"       // Elevation 3
    readonly property color surfaceContainerHighest: "#36343B"    // Elevation 4
    
    // === INVERSE COLORS ===
    readonly property color inverseSurface: "#E6E1E5"             // For contrast
    readonly property color textOnInverseSurface: "#313033"       // Text on inverse surface
    readonly property color inversePrimary: "#6750A4"             // Primary 40
    
    // === OUTLINE COLORS ===
    readonly property color outline: "#938F99"                    // Neutral Variant 60 - borders
    readonly property color outlineVariant: "#49454F"             // Neutral Variant 30 - subtle borders
    
    // === SCRIM (for modals/overlays) ===
    readonly property color scrim: "#000000"
    
    // SHAPE SYSTEM - Corner radius tokens
    
    readonly property int shapeNone: 0              // No rounding (0dp)
    readonly property int shapeExtraSmall: 4        // 4dp - Chips, small buttons
    readonly property int shapeSmall: 8             // 8dp - Cards, small components
    readonly property int shapeMedium: 12           // 12dp - Medium components, panels
    readonly property int shapeLarge: 16            // 16dp - Large components, dialogs
    readonly property int shapeExtraLarge: 28       // 28dp - Extra large surfaces
    readonly property int shapeFull: 9999           // Pill shape - FABs, some buttons
    
    // Component-specific shape tokens
    readonly property int shapeButton: shapeExtraLarge      // 28dp (pill shape)
    readonly property int shapeCard: shapeMedium            // 12dp
    readonly property int shapeChip: shapeSmall             // 8dp
    readonly property int shapeDialog: shapeExtraLarge      // 28dp
    readonly property int shapeFab: shapeLarge              // 16dp
    readonly property int shapeMenu: shapeExtraSmall        // 4dp
    readonly property int shapeSheet: shapeExtraLarge       // 28dp
    readonly property int shapeTooltip: shapeExtraSmall     // 4dp
    
    // Bar-specific shapes
    readonly property int barRadius: shapeMedium            // 12dp - rounded bar (CONFIGURE: set to shapeNone for flat)
    readonly property int barRadiusFlat: shapeNone          // 0dp - flat bar
    readonly property int barItemRadius: shapeSmall         // 8dp - bar items
    
    // ============================================================================
    // ELEVATION SYSTEM
    // ============================================================================
    //
    
    readonly property int elevationLevel0: 0
    readonly property int elevationLevel1: 1
    readonly property int elevationLevel2: 3
    readonly property int elevationLevel3: 6
    readonly property int elevationLevel4: 8
    readonly property int elevationLevel5: 12
    
    readonly property color shadowColor: "#40000000"        // 25% opacity black
    
    // ============================================================================
    // TYPOGRAPHY SYSTEM
    // ============================================================================
    
    readonly property string fontFamily: "Roboto"
    
    // Display styles (largest text)
    readonly property int fontDisplayLarge: 57
    readonly property int fontDisplayMedium: 45
    readonly property int fontDisplaySmall: 36
    
    // Headline styles
    readonly property int fontHeadlineLarge: 32
    readonly property int fontHeadlineMedium: 28
    readonly property int fontHeadlineSmall: 24
    
    // Title styles
    readonly property int fontTitleLarge: 22
    readonly property int fontTitleMedium: 16
    readonly property int fontTitleSmall: 14
    
    // Body styles (most common text)
    readonly property int fontBodyLarge: 16
    readonly property int fontBodyMedium: 14
    readonly property int fontBodySmall: 12
    
    // Label styles (buttons, tabs, labels)
    readonly property int fontLabelLarge: 14
    readonly property int fontLabelMedium: 12
    readonly property int fontLabelSmall: 11
    
    // Font weights
    readonly property int fontWeightRegular: Font.Normal    // 400
    readonly property int fontWeightMedium: Font.Medium     // 500
    readonly property int fontWeightBold: Font.Bold         // 700
    
    // ============================================================================
    // MOTION SYSTEM - Animation durations and easing
    // ============================================================================
    
    // Duration tokens (in milliseconds)
    readonly property int motionDuration50: 50              // Micro-interactions
    readonly property int motionDuration100: 100            // Simple transitions
    readonly property int motionDuration150: 150            // Small component animations (CONFIGURE: default)
    readonly property int motionDuration200: 200            // Medium transitions
    readonly property int motionDuration250: 250            // Standard transitions (Material 3 default)
    readonly property int motionDuration300: 300            // Complex transitions
    readonly property int motionDuration350: 350            // Large component animations
    readonly property int motionDuration400: 400            // Sheet/dialog entrance
    readonly property int motionDuration450: 450            // Extended animations
    readonly property int motionDuration500: 500            // Long transitions
    readonly property int motionDuration700: 700            // Very long transitions
    
    // Easing curves (Material Design 3)
    readonly property int easingStandard: Easing.Bezier
    readonly property var easingStandardCurve: [0.2, 0.0, 0, 1.0]       // Emphasized decelerate
    
    readonly property int easingEmphasized: Easing.Bezier
    readonly property var easingEmphasizedCurve: [0.2, 0.0, 0, 1.0]     // Emphasized
    
    readonly property int easingDecelerate: Easing.Bezier
    readonly property var easingDecelerateCurve: [0.0, 0.0, 0, 1.0]     // Enter screen
    
    readonly property int easingAccelerate: Easing.Bezier
    readonly property var easingAccelerateCurve: [0.3, 0.0, 1.0, 1.0]   // Exit screen
    
    readonly property int easingLegacy: Easing.OutCubic                 // Material 2 compatibility
    
    // ============================================================================
    // DIMENSIONS & SPACING
    // ============================================================================
    
    // Material Design 3 spacing scale (4dp grid)
    readonly property int space0: 0
    readonly property int space1: 4
    readonly property int space2: 8
    readonly property int space3: 12
    readonly property int space4: 16
    readonly property int space5: 20
    readonly property int space6: 24
    readonly property int space7: 28
    readonly property int space8: 32
    readonly property int space9: 36
    readonly property int space10: 40
    
    // Bar dimensions (CONFIGURE HERE)
    readonly property int barHeight: 48                     // Material standard app bar height (OPTIONS: 32, 40, 48)
    readonly property int barPaddingHorizontal: space4      // 16dp
    readonly property int barPaddingVertical: space2        // 8dp
    readonly property int barMarginTop: 0                   // Top margin (CONFIGURE: 0 for edge-to-edge, 8 for floating)
    readonly property int barMarginHorizontal: 0            // Side margin (CONFIGURE: 0 for edge-to-edge, 8 for floating)
    
    // Icon sizes (CONFIGURE HERE)
    readonly property int iconSizeSmall: 18                 // Small icons
    readonly property int iconSizeMedium: 24                // Standard icons
    readonly property int iconSizeLarge: 32                 // Large icons
    readonly property int iconSizeTray: 24                  // System tray icons (CONFIGURE: 20, 24, 28)
    readonly property int iconSizeIndicator: 20             // System indicators
    readonly property int iconSizeWorkspace: 18             // Workspace indicators
    
    // Component dimensions
    readonly property int buttonHeight: 40                  // Standard button height
    readonly property int buttonHeightSmall: 32             // Small button
    readonly property int buttonHeightLarge: 56             // Large button (FAB)
    readonly property int chipHeight: 32                    // Chip height
    readonly property int listItemHeight: 56                // Single line list item
    
    // ============================================================================
    // STATE LAYERS - Interaction feedback overlays
    // ============================================================================
    
    // Material 3 state layer opacities
    readonly property real stateHoverOpacity: 0.08          // 8% overlay on hover
    readonly property real stateFocusOpacity: 0.12          // 12% overlay on focus
    readonly property real statePressedOpacity: 0.12        // 12% overlay on press
    readonly property real stateDraggedOpacity: 0.16        // 16% overlay when dragged
    readonly property real stateDisabledOpacity: 0.38       // 38% opacity when disabled
    
    // State layer color helper
    function stateLayerColor(baseColor, opacity) {
        return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, opacity)
    }
    
    // ============================================================================
    // HELPER FUNCTIONS
    // ============================================================================
    
    // Create surface tint overlay (for elevation in dark theme)
    function surfaceTint(level) {
        // Material 3 uses primary color as tint overlay
        var opacities = [0, 0.05, 0.08, 0.11, 0.12, 0.14]
        var opacity = opacities[Math.min(level, 5)]
        return Qt.rgba(primary.r, primary.g, primary.b, opacity)
    }
    
    // Apply state layer to a color
    function withStateLayer(baseColor, state) {
        var opacity = 0
        switch(state) {
            case "hover": opacity = stateHoverOpacity; break
            case "focus": opacity = stateFocusOpacity; break
            case "pressed": opacity = statePressedOpacity; break
            case "dragged": opacity = stateDraggedOpacity; break
        }
        return Qt.tint(baseColor, stateLayerColor(primary, opacity))
    }
    
    // Create disabled version of a color
    function withDisabled(color) {
        return Qt.rgba(color.r, color.g, color.b, stateDisabledOpacity)
    }
    
    // Mix two colors
    function mixColors(color1, color2, ratio) {
        return Qt.rgba(
            color1.r * (1 - ratio) + color2.r * ratio,
            color1.g * (1 - ratio) + color2.g * ratio,
            color1.b * (1 - ratio) + color2.b * ratio,
            1.0
        )
    }
}
