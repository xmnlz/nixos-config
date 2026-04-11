import QtQuick
import QtQuick.Effects

import qs.etc

Item {
  id: root
  default required property Item child

  property int blockMaxHeight: 36
  property int hPadding: 10
  property int wPadding: 16

  children: [shadow, bg, child]   // shadow behind bg, bg behind child

  implicitWidth: child.implicitWidth + wPadding * 2   // ← symmetric, not just one side
  implicitHeight: Math.min(blockMaxHeight, child.implicitHeight + hPadding * 2)

  Rectangle {
    id: bg
    anchors.fill: parent
    radius: Theme.rounding
    color: Theme.surface

    layer.enabled: true // required for MultiEffect to work
  }

  MultiEffect {
    id: shadow
    source: bg
    anchors.fill: bg

    shadowEnabled: true
    shadowColor: "#50000000"
    shadowBlur: 0.5
    shadowVerticalOffset: 2
    shadowHorizontalOffset: 1
  }
}
