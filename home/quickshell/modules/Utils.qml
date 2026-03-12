pragma Singleton
import QtQuick

QtObject {
  function formatSeconds(secs: int): string {
    if (secs <= 0) return ""
    const h = Math.floor(secs / 3600)
    const m = Math.floor((secs % 3600) / 60)
    if (h > 0 && m > 0) return h + "h " + m + "m"
    if (h > 0) return h + "h"
    return m + "m"
  }
}

