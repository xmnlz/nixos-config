{inputs, ...}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    # Setting `settings` at all turns settings.json into a read-only store
    # symlink, so the in-shell settings UI can no longer save.
    settings = {
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
              showAudioIcon = true;
              showMicIcon = true;
              showMicPercent = false;
              showScreenSharingIcon = true;
            }
          ];
        }
      ];
      barElevationEnabled = false;

      showWorkspaceIndex = true;
      workspaceFollowFocus = true;
      workspaceFocusedBorderColor = "surfaceText";
      workspaceFocusedBorderThickness = 3;

      notificationCompactMode = true;
      notificationOverlayEnabled = true;
      notificationHistoryMaxAgeDays = 3;
      osdPosition = 7;
      osdAlwaysShowValue = true;
      osdPowerProfileEnabled = true;

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
