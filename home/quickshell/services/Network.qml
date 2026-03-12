pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  // ── state ──────────────────────────────────────────────
  property string ssid: ""
  property int strength: 0
  property bool connected: false
  property bool ethernet: false
  property bool wifiEnabled: true

  readonly property string icon: {
    if (ethernet) return "settings_ethernet"
    if (!connected) return "signal_wifi_off"
    if (strength >= 75) return "network_wifi"
    if (strength >= 50) return "network_wifi_3_bar"
    if (strength >= 25) return "network_wifi_2_bar"
    return "network_wifi_1_bar"
  }

  readonly property string label: {
    if (ethernet) return "Ethernet"
    if (connected) return ssid
    if (wifiEnabled) return "Not connected"
    return "Wi-Fi off"
  }

  // ── poll every 10s ─────────────────────────────────────
  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      wifiProc.running = false
      wifiProc.running = true
      ethProc.running = false
      ethProc.running = true
    }
  }

  // active wifi connection
  Process {
    id: wifiProc
    command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL", "dev", "wifi"]
    environment: ({ LANG: "C.UTF-8", LC_ALL: "C.UTF-8" })
    stdout: StdioCollector {
      onStreamFinished: {
        const active = text.trim().split("\n").find(l => l.startsWith("yes:"))
        if (active) {
          const parts = active.split(":")
          root.ssid = parts[1] ?? ""
          root.strength = parseInt(parts[2]) || 0
          root.connected = true
          root.ethernet = false
        } else if (!root.ethernet) {
          root.connected = false
          root.ssid = ""
          root.strength = 0
        }
      }
    }
  }

  // active ethernet connection
  Process {
    id: ethProc
    command: ["nmcli", "-t", "-f", "TYPE,STATE", "dev"]
    environment: ({ LANG: "C.UTF-8", LC_ALL: "C.UTF-8" })
    stdout: StdioCollector {
      onStreamFinished: {
        root.ethernet = text.trim().split("\n")
          .some(l => l.startsWith("ethernet:") && l.includes("connected"))
        if (root.ethernet) root.connected = true
      }
    }
  }
}
