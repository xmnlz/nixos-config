import QtQuick

import qs.etc
import qs.services

Item {
  id: root

  implicitWidth: clockText.implicitWidth
  implicitHeight: clockText.implicitHeight

  Text {
    id: clockText

    text: Time.time
    color: Theme.text

    font {
      family: Theme.fontFamily
      pointSize: Theme.fontSize
      bold: true
    }
  }
}
