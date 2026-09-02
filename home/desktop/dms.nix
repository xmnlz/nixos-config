{inputs, ...}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    # Only settings that differ from the DMS defaults live here. Anything not
    # listed falls back to upstream, and per-key omissions inside barConfigs do
    # too. Note that declaring `settings` at all makes settings.json a
    # read-only store symlink, so the in-shell settings UI cannot save
    settings = {
      # Idle, lock and suspend
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
      lockScreenNotificationMode = 2;
      fadeToDpmsEnabled = false;
      fadeToLockEnabled = false;

      # Battery thresholds
      batteryLowThreshold = 40;
      batteryCriticalThreshold = 20;
      batteryNotifyLow = true;

      # Fingerprint unlock, matching services.fprintd from nixos-hardware
      enableFprint = true;
      greeterEnableFprint = true;

      # Clock
      clockFormat = "24h";
      clockDateFormat = "dddd - dd/MM/yyyy";

      # Theming. Dynamic (matugen) colours, but every app template is off
      # because those files are managed declaratively elsewhere
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenScheme = "scheme-content";
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

      # Fonts, kept in sync with fonts.fontconfig in modules/desktop/general.nix
      fontFamily = "JetBrainsMono Nerd Font";
      monoFontFamily = "JetBrainsMono Nerd Font Mono";

      # Bar. Unlisted keys fall back to the upstream bar defaults
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          fontScale = 1.1;
          iconScale = 1.25;
          transparency = 0.8;
          widgetTransparency = 0.8;
          shadowColorMode = "text";
          scrollYBehavior = "none";

          leftWidgets = ["workspaceSwitcher"];
          centerWidgets = ["clock"];
          rightWidgets = [
            "notificationButton"
            "idleInhibitor"
            "battery"
            "systemTray"
            {
              id = "controlCenterButton";
              # These three differ from the global controlCenterShow* values,
              # which is what an omitted key would otherwise fall back to
              showAudioIcon = true;
              showMicIcon = true;
              showMicPercent = false;
              showScreenSharingIcon = true;
            }
          ];
        }
      ];
      barElevationEnabled = false;

      # Workspaces
      showWorkspaceIndex = true;
      workspaceFollowFocus = true;
      workspaceFocusedBorderColor = "surfaceText";
      workspaceFocusedBorderThickness = 3;

      # Notifications and OSD
      notificationCompactMode = true;
      notificationOverlayEnabled = true;
      notificationHistoryMaxAgeDays = 3;
      osdPosition = 7;
      osdAlwaysShowValue = true;
      osdPowerProfileEnabled = true;

      # Widgets and indicators
      showLauncherButton = false;
      weatherEnabled = false;
      updaterHideWidget = true;
      audioVisualizerEnabled = false;
      audioWheelScrollAmount = 10;
      controlCenterShowMicPercent = true;
      controlCenterShowVpnIcon = false;
      privacyShowCameraIcon = true;
      privacyShowMicIcon = true;
      privacyShowScreenShareIcon = true;
      screenPreferences.wallpaper = ["all"];
      showOnLastDisplay.dock = false;
      displaySnapToEdge = false;
      modalDarkenBackground = false;
      notepadUseMonospace = false;

      # Power menu
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

      # Built-in plugins that are switched off
      builtInPluginSettings = {
        dms_notepad.enabled = false;
        dms_settings.enabled = false;
        dms_settings_search.enabled = false;
        dms_sysmon.enabled = false;
      };
    };
  };
}
