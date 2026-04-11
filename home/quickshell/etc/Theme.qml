pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  property int rounding: 8

  property string fontFamily: "JetBrainsMono Nerd Font Mono"
  property string iconFontFamily: "Material Symbols Rounded"

  // NOTE: Use the font.pointSize only!
  property int fontSize: 12
  property int iconSize: 20

  // ── Backgrounds ─────────────────────────────────────────────────────────
  // The main bar/panel background
  property string base: "#282828"
  // First level widget background (e.g. clock pill, workspace pill)
  property string surface: "#383838"
  // Second level widget background (e.g. a button inside a pill)
  property string overlay: "#484848"

  // ── Hover states ────────────────────────────────────────────────────────
  // Hovered state for surface widgets
  property string surfaceHover: "#585858"
  // Hovered state for overlay widgets
  property string overlayHover: "#686868"

  // ── Active / selected state ──────────────────────────────────────────────
  // A widget that is currently active/selected (e.g. focused workspace dot)
  property string active: "#b3aea0"

  // ── Text ────────────────────────────────────────────────────────────────
  // Primary text — used for labels, clock, workspace numbers
  property string text: "#d3cec0"
  // Secondary text — used for less important labels, hints, subtitles
  property string subtext: "#c3beb0"

  // ── Semantic ────────────────────────────────────────────────────────────
  // Red — errors, urgent notifications, critical battery
  property string urgent: "#e25d5b"
  // Yellow/Orange — warnings, medium battery, pending states
  property string warning: "#d9a456"
  // Blue — informational, network activity, media accents
  property string info: "#6aadbe"
}
