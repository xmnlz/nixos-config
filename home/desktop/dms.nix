{ config, ... }:

{
  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = true;

    enableDynamicTheming = false;
    enableClipboardPaste = false;

    systemd.enable = true;

    settings = {
      currentThemeName = "custom";
      currentThemeCategory = "registry";
      customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/rosePine/theme.json";
      registryThemeVariants = {
        rosePine = "rosePine";
      };

      acMonitorTimeout = 180;
      acLockTimeout = 180;
      acSuspendTimeout = 600;
      acSuspendBehavior = 2;

      batteryMonitorTimeout = 180;
      batteryLockTimeout = 180;
      batterySuspendTimeout = 300;
      batterySuspendBehavior = 2;
      batteryChargeLimit = 100;

      lockBeforeSuspend = false;
      loginctlLockIntegration = true;

      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;

      cornerRadius = 16;
      showLauncherButton = false;
      controlCenterShowMicPercent = true;

      showWorkspaceIndex = true;
      workspaceFollowFocus = true;
      workspaceFocusedBorderColor = "surfaceText";
      workspaceFocusedBorderThickness = 3;
      audioVisualizerEnabled = false;
      powerActionHoldDuration = 1;

      audioWheelScrollAmount = 10;
      appIdSubstitutions = [ ];

      clockDateFormat = "dddd - dd/MM/yyyy";
      weatherEnabled = false;

      fontFamily = "JetBrainsMonoNL Nerd Font";
      monoFontFamily = "JetBrainsMonoNL Nerd Font Mono";

      syncModeWithPortal = false;
      notificationOverlayEnabled = true;
      modalDarkenBackground = false;
      lockScreenNotificationMode = 2;
      notificationCompactMode = true;
      notificationHistoryMaxAgeDays = 3;
      osdAlwaysShowValue = true;
      osdPosition = 7;
      osdPowerProfileEnabled = true;
      powerMenuActions = [
        "reboot"
        "logout"
        "lock"
        "poweroff"
        "suspend"
        "restart"
        "hibernate"
      ];
      updaterHideWidget = true;

      screenPreferences = {
        wallpaper = [ ];
        dock = [ ];
        notepad = [ ];
      };
      showOnLastDisplay.dock = false;
      displaySnapToEdge = false;

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets =  [ 
            "workspaceSwitcher"
          ];
          centerWidgets = [
            {
              id = "clock";
              enabled = true;
            }
          ];
          rightWidgets = [
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "idleInhibitor";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
            }
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
              showAudioIcon = true;
              showAudioPercent = false;
              showVpnIcon = false;
              showBrightnessIcon = true;
              showBrightnessPercent = true;
              showMicIcon = true;
              showMicPercent = false;
              showBatteryIcon = false;
              showPrinterIcon = false;
              showScreenSharingIcon = true;
            }
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 0.8;
          widgetTransparency = 0.8;
          squareCorners = false;
          noBackground = false;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          removeWidgetPadding = false;
          widgetPadding = 8;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          fontScale = 1.1;
          iconScale = 1.25;
          autoHide = false;
          autoHideDelay = 250;
          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = true;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "none";
          shadowIntensity = 0;
          shadowOpacity = 60;
          shadowColorMode = "text";
          shadowCustomColor = "#000000";
          clickThrough = false;
        }
      ];

      builtInPluginSettings = {
        dms_settings_search = {
          enabled = false;
        };
        dms_settings.enabled = false;
        dms_notepad.enabled = false;
        dms_sysmon.enabled = false;
      };
    };
  };
}
