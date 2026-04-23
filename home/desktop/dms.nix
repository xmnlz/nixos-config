{ config, ... }:

{
  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = true;
    enableDynamicTheming = false;
    enableClipboardPaste = false;

    systemd.enable = true;

    settings = {

      # --- Theme ---
      currentThemeName = "custom";
      currentThemeCategory = "registry";
      customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/rosePine/theme.json";
      registryThemeVariants = {
        rosePine = "rosePine";
      };

      # --- Lock screen: core behaviour ---
      lockAtStartup = true;
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;

      lockScreenActiveMonitor = "all";
      lockScreenPowerOffMonitorsOnLock = false;
      lockScreenInactiveColor = "#000000";

      # --- Lock screen: authentication ---
      enableFprint = true;
      maxFprintTries = 15;

      enableU2f = false;
      u2fMode = "or";

      # --- Greeter ---
      greeterEnableFprint = false;
      greeterEnableU2f = false;
      greeterRememberLastUser = true;
      greeterRememberLastSession = true;

      # --- Lock screen: UI ---
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenShowMediaPlayer = true;

      # --- Lock screen: notifications ---
      lockScreenNotificationMode = 2;

      # --- Lock / DPMS transitions ---
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;

      # --- Power: AC ---
      acMonitorTimeout = 180;
      acLockTimeout = 180;
      acSuspendTimeout = 600;
      acSuspendBehavior = 2;

      # --- Power: battery ---
      batteryMonitorTimeout = 180;
      batteryLockTimeout = 180;
      batterySuspendTimeout = 300;
      batterySuspendBehavior = 2;
      batteryChargeLimit = 100;

      # --- General UI ---
      cornerRadius = 16;
      showLauncherButton = false;
      controlCenterShowMicPercent = true;

      # --- Workspace ---
      showWorkspaceIndex = true;
      workspaceFollowFocus = true;
      workspaceFocusedBorderColor = "surfaceText";
      workspaceFocusedBorderThickness = 3;

      # --- Audio ---
      audioVisualizerEnabled = false;
      audioWheelScrollAmount = 10;

      # --- Power menu ---
      powerActionHoldDuration = 1;
      powerMenuActions = [
        "reboot"
        "logout"
        "lock"
        "poweroff"
        "suspend"
        "restart"
        "hibernate"
      ];

      # --- Misc ---
      appIdSubstitutions = [ ];
      clockDateFormat = "dddd - dd/MM/yyyy";
      weatherEnabled = false;

      # --- Fonts ---
      fontFamily = "JetBrainsMonoNL Nerd Font";
      monoFontFamily = "JetBrainsMonoNL Nerd Font Mono";

      # --- Notifications / OSD ---
      notificationOverlayEnabled = true;
      notificationCompactMode = true;
      notificationHistoryMaxAgeDays = 3;

      osdAlwaysShowValue = true;
      osdPosition = 7;
      osdPowerProfileEnabled = true;

      modalDarkenBackground = false;
      syncModeWithPortal = false;
      updaterHideWidget = true;

      # --- Screen prefs ---
      screenPreferences = {
        wallpaper = [ ];
        dock = [ ];
        notepad = [ ];
      };

      showOnLastDisplay.dock = false;
      displaySnapToEdge = false;

      # --- Bar ---
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;

          screenPreferences = [ "all" ];
          showOnLastDisplay = true;

          leftWidgets = [
            "workspaceSwitcher"
          ];

          centerWidgets = [
            {
              id = "clock";
              enabled = true;
            }
          ];

          rightWidgets = [
            { id = "notificationButton"; enabled = true; }
            { id = "idleInhibitor"; enabled = true; }
            { id = "battery"; enabled = true; }
            { id = "systemTray"; enabled = true; }
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
          maximizeDetection = true;

          widgetPadding = 8;
          removeWidgetPadding = false;

          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;

          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;

          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;

          fontScale = 1.1;
          iconScale = 1.25;

          autoHide = false;
          autoHideDelay = 250;

          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;

          popupGapsAuto = true;
          popupGapsManual = 4;

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

      # --- Plugins ---
      builtInPluginSettings = {
        dms_settings_search.enabled = false;
        dms_settings.enabled = false;
        dms_notepad.enabled = false;
        dms_sysmon.enabled = false;
      };
    };
  };
}
