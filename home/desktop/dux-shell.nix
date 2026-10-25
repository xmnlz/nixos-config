{
  inputs,
  ...
}: {
  imports = [
    inputs.dux-shell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    # Setting `settings` at all turns settings.json into a read-only store
    # symlink, so the in-shell settings UI can no longer save.
    settings = {
      # Without it DMS reruns every migration from version 0 on each start.
      configVersion = 42;

      acLockTimeout = 180;
      acPostLockMonitorTimeout = 30;
      acSuspendBehavior = 2;
      acSuspendTimeout = 600;
      batteryLockTimeout = 180;
      batteryPostLockMonitorTimeout = 30;
      batterySuspendBehavior = 2;
      batterySuspendTimeout = 300;
      lockAtStartup = true;
      lockBeforeSuspend = true;
      fadeToDpmsEnabled = false;
      fadeToLockEnabled = false;

      batteryLowThreshold = 40;
      batteryCriticalThreshold = 20;
      batteryNotifyLow = true;

      enableFprint = true;
      greeterEnableFprint = true;

      clockFormat = "24h";
      clockDateFormat = "dddd - dd/MM/yyyy";

      # Dynamic colours, but every matugen template is off since those apps are
      # themed declaratively elsewhere.
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenSpec = "2025";
      matugenTemplateAlacritty = false;
      matugenTemplateDgop = false;
      matugenTemplateEmacs = false;
      matugenTemplateEquibop = false;
      matugenTemplateFirefox = false;
      matugenTemplateFoot = false;
      matugenTemplateGhostty = false;
      matugenTemplateGtk = false;
      matugenTemplateHyprland = false;
      matugenTemplateKcolorscheme = false;
      matugenTemplateKitty = false;
      matugenTemplateMangowc = false;
      matugenTemplateNeovimSetBackground = false;
      matugenTemplateNiri = false;
      matugenTemplatePywalfox = false;
      matugenTemplateQt5ct = false;
      matugenTemplateQt6ct = false;
      matugenTemplateVencord = false;
      matugenTemplateVesktop = false;
      matugenTemplateVscode = false;
      matugenTemplateWezterm = false;
      matugenTemplateZed = false;
      matugenTemplateZenBrowser = false;
      syncModeWithPortal = false;

      # Kept in sync with fonts.fontconfig in modules/desktop/general.nix.
      fontFamily = "JetBrainsMono Nerd Font";
      monoFontFamily = "JetBrainsMono Nerd Font Mono";

      # This array replaces the upstream one wholesale rather than merging, and
      # DMS drops any bar whose `enabled` is missing. Leave it out and the bar
      # silently never renders.
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          fontScale = 1.1;
          iconScale = 1.25;
          transparency = 0.8;
          widgetTransparency = 0.8;
          # Otherwise the global surface opacity overrides `transparency` above.
          followInterfaceStyle = false;
          widgetFollowInterfaceStyle = false;
          shadowColorMode = "text";
          scrollYBehavior = "none";

          leftWidgets = [
            {
              id = "workspaceSwitcher";
              showWorkspaceIndex = true;
              workspaceFollowFocus = true;
              workspaceFocusedBorderColor = "surfaceText";
              workspaceFocusedBorderThickness = 3;
              workspaceIndicatorStyle = "dots";
            }
          ];
          centerWidgets = ["clock"];
          rightWidgets = [
            "notificationButton"
            {
              id = "battery";
              showBatteryPercentOnlyOnBattery = true;
            }
            "systemTray"
            {
              id = "controlCenterButton";
              showMicIcon = true;
              showVpnIcon = false;
            }
          ];
        }
      ];
      barElevationEnabled = false;

      # Like barConfigs, these lists replace the defaults wholesale.
      controlCenterWidgets = [
        { id = "user"; enabled = true; w = 5; h = 1; col = 0; row = 0; }
        { id = "settings"; enabled = true; w = 1; h = 1; small = true; col = 5; row = 0; }
        { id = "lock"; enabled = true; w = 1; h = 1; small = true; col = 6; row = 0; }
        { id = "power"; enabled = true; w = 1; h = 1; small = true; col = 7; row = 0; }
        { id = "brightnessSlider"; enabled = true; w = 4; h = 1; col = 0; row = 1; }
        { id = "volumeSlider"; enabled = true; w = 4; h = 1; col = 4; row = 1; }
        { id = "wifi"; enabled = true; w = 4; h = 1; col = 0; row = 2; }
        { id = "bluetooth"; enabled = true; w = 4; h = 1; col = 4; row = 2; }
        { id = "audioOutput"; enabled = true; w = 4; h = 1; col = 0; row = 3; }
        { id = "audioInput"; enabled = true; w = 4; h = 1; col = 4; row = 3; }
        { id = "nightMode"; enabled = true; w = 2; h = 1; col = 0; row = 4; }
        { id = "doNotDisturb"; enabled = true; w = 2; h = 1; col = 2; row = 4; }
        { id = "runningApps"; enabled = true; w = 7; h = 1; small = true; col = 0; row = 5; }
        { id = "edit"; enabled = true; w = 1; h = 1; small = true; col = 7; row = 5; }
        { id = "idleInhibitor"; enabled = true; w = 4; h = 1; }
      ];

      dashCards = [
        { id = "clock"; w = 4; h = 1; col = 0; row = 0; }
        { id = "weather"; w = 1; h = 1; }
        { id = "calendar"; w = 4; h = 4; col = 0; row = 1; }
        { id = "media"; w = 2; h = 4; col = 4; row = 1; }
        { id = "sysmon"; w = 2; h = 1; }
      ];
      dashOptions = {
        calendar.weekends = true;
        clock.date = true;
      };
      wellbeingEnabled = false;

      notificationCompactMode = true;
      notificationOverlayEnabled = true;
      notificationHistoryMaxAgeDays = 3;
      osdPosition = 7;
      osdAlwaysShowValue = true;
      osdPowerProfileEnabled = true;

      weatherEnabled = false;
      audioWheelScrollAmount = 10;
      screenPreferences.wallpaper = ["all"];
      displaySnapToEdge = false;
      modalDarkenBackground = false;
      notepadUseMonospace = false;

      # DMS records here that it already wrote its floating-window rule. The
      # file is read-only, so without this it rewrites the rule on every start.
      dmsWindowsFloatingSeeded = ["hyprland"];

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

      builtInPluginSettings = {
        dms_notepad.enabled = false;
        dms_settings.enabled = false;
        dms_settings_search.enabled = false;
        dms_sysmon.enabled = false;
      };
    };
  };
}
