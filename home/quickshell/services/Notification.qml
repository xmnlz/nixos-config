pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  property var _list: []
  property int _tick: 0

  readonly property var notifications: _list
  readonly property int count: _list.length

  function remove(notif) {
    root._list = root._list.filter(n => n !== notif)
    root._tick++
  }

  function clearAll() {
    root._list.forEach(n => {
      if (n.notification && !n.notification.Retainable.dropped)
        n.notification.dismiss()
    })
    root._list = []
    root._tick++
  }

  NotificationServer {
    id: server
    keepOnReload: false

    actionsSupported: true
    bodyMarkupSupported: true
    imageSupported: true

    onNotification: incoming => {
      incoming.tracked = true
      const obj = root.notifComp.createObject(root, { notification: incoming })
      root._list = [...root._list, obj]
      root._tick++
    }
  }

  property Component notifComp: Component {
    QtObject {
      id: self

      required property Notification notification

      readonly property string summary: self.notification.summary
      readonly property string body:    self.notification.body
      readonly property string appName: self.notification.appName
      readonly property string appIcon: self.notification.appIcon
      readonly property string image:   self.notification.image
      readonly property int    urgency: self.notification.urgency
      readonly property date   time:    new Date()

      readonly property Connections _drop: Connections {
        target: self.notification.Retainable
        function onDropped()        { root.remove(self) }
        function onAboutToDestroy() { self.destroy()    }
      }

      readonly property Connections _close: Connections {
        target: self.notification
        function onClosed() { root.remove(self) }
      }
    }
  }
}
