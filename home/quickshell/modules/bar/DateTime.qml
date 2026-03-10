import QtQuick
import qs.modules

Item {
  id: root
  implicitWidth: col.implicitWidth
  implicitHeight: col.implicitHeight

  Column {
    id: col
    anchors.centerIn: parent
    spacing: 0

    Text {
      id: timeText
      anchors.horizontalCenter: parent.horizontalCenter
      text: Qt.formatTime(new Date(), "hh:mm")
      color: Appearance.colors.m3on_background
      font.pixelSize: 13
      font.bold: true
    }

    Text {
      id: dateText
      anchors.horizontalCenter: parent.horizontalCenter
      text: Qt.formatDate(new Date(), "ddd, dd MMM")
      color: Appearance.colors.m3on_surface_variant
      font.pixelSize: 10
    }
  }

  Timer {
    interval: 60_000
    running: true
    repeat: true
    onTriggered: {
      timeText.text = Qt.formatTime(new Date(), "hh:mm")
      dateText.text = Qt.formatDate(new Date(), "ddd, dd MMM")
    }
  }
}

