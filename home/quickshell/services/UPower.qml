pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.etc

Singleton {
  id: root

  readonly property int thresholdCritical: 20
  readonly property int thresholdWarning: 40
  readonly property int thresholdSurplus: 80

  readonly property int percentage: Math.round(UPower.displayDevice.percentage * 100)
  readonly property bool exists: UPower.displayDevice.isLaptopBattery
  readonly property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
  readonly property bool isFullyCharged: UPower.displayDevice.state === UPowerDeviceState.FullyCharged

  readonly property list<string> icons: ["battery_android_frame_1", "battery_android_frame_2", "battery_android_frame_3", "battery_android_frame_4", "battery_android_frame_5", "battery_android_frame_6"]

  readonly property string icon: {
    if (isCharging)
      return "battery_android_frame_bolt";
    if (isFullyCharged)
      return "battery_android_frame_full";
    if (percentage <= thresholdCritical)
      return "battery_android_alert";

    const index = Math.round((percentage / 100) * (icons.length - 1));
    return icons[index];
  }

  readonly property color color: {
    if (percentage >= thresholdSurplus)
      return Theme.info;
    if (percentage > thresholdWarning)
      return Theme.text;
    if (percentage > thresholdCritical)
      return Theme.warning;

    return Theme.urgent;
  }
}
