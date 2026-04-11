import QtQuick
import QtQuick.Layouts

import qs.etc
import qs.services

Item {
  id: root
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row
    anchors.centerIn: parent

    Text {
      text: UPower.percentage + "%"
      color: UPower.color_function(Theme.text)

      font {
        family: Theme.fontFamily
        pointSize: Theme.fontSize
        bold: true
      }
    }

    MatearialIcon {
      name: UPower.icon
    }
  }
}
