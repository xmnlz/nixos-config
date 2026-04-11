pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

import qs.etc

Singleton {
  id: root

  readonly property int percentage_warning: 40
  readonly property int percentage_critical: 20
  readonly property int percentage_surplus: 80

  property string perfomance: PowerProfiles.degradationReason

  readonly property list<string> icon_array: ["battery_android_alert", "battery_android_frame_2", "battery_android_frame_3", "battery_android_frame_6", "battery_android_frame_full"]
  property int icon_index: 0
  property string icon: "NULL"

  property int percentage: Math.round(UPower.displayDevice.percentage * 100)
  property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
  property bool exists: UPower.displayDevice.isLaptopBattery

  Component.onCompleted: console.log(perfomance)

  function color_function(normal) {
    if (percentage >= percentage_surplus)
      return Theme.info;
    if (percentage > percentage_warning)
      return normal;
    if (percentage > percentage_critical)
      return Theme.warning;
    return Theme.urgent;
  }

  function is_color_normal() {
    return percentage > percentage_warning && percentage < percentage_surplus;
  }

  function update_icon() {
    if (isCharging) {
      icon = "battery_android_frame_bolt";
    } else {
      let normalized = percentage / 100.0;
      icon_index = Math.round(normalized * (icon_array.length - 1));
      icon = icon_array[icon_index];
    }
  }

  onPercentageChanged: update_icon()
  onIsChargingChanged: update_icon()
}
