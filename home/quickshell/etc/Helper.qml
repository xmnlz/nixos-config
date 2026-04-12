pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  function getTrayIcon(id: string, icon: string): string {
    if (icon.includes("?path=")) {
      const [name, path] = icon.split("?path=");
      icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
    }

    return icon;
  }
}
