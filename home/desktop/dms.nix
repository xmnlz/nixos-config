{inputs, ...}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableClipboardPaste = false;

    systemd.enable = true;

    settings = {
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      # customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/rosePine/theme.json";
      # registryThemeVariants = {
      #   rosePine = "rosePine";
      # };

      # Matugen (dynamic theming)
      matugenScheme = "scheme-content";
      runUserMatugenTemplates = true;
      matugenTargetMonitor = "";
      runDmsMatugenTemplates = true;

      matugenTemplateGtk = false;
      matugenTemplateNiri = false;
      matugenTemplateHyprland = false;
      matugenTemplateMangowc = false;
      matugenTemplateQt5ct = false;
      matugenTemplateQt6ct = false;
      matugenTemplateFirefox = false;
      matugenTemplatePywalfox = false;
      matugenTemplateZenBrowser = false;
      matugenTemplateVesktop = false;
      matugenTemplateEquibop = false;
      matugenTemplateGhostty = false;
      matugenTemplateKitty = false;
      matugenTemplateFoot = false;
      matugenTemplateAlacritty = false;
      matugenTemplateNeovim = false;
      matugenTemplateWezterm = false;
      matugenTemplateDgop = false;
      matugenTemplateKcolorscheme = false;
      matugenTemplateVscode = false;
      matugenTemplateEmacs = false;
      matugenTemplateZed = false;

      cornerRadius = 16;
      popupTransparency = 1.0;
      dockTransparency = 1.0;
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      controlCenterTileColorMode = "primary";
      buttonColorMode = "primary";
      modalDarkenBackground = false;
      syncModeWithPortal = false;
      showLauncherButton = false;
      nightModeEnabled = false;

      # compositor-specific; -1 = use compositor default
      niriLayoutGapsOverride = -1;
      niriLayoutRadiusOverride = -1;
      niriLayoutBorderSize = -1;

      hyprlandLayoutGapsOverride = -1;
      hyprlandLayoutRadiusOverride = -1;
      hyprlandLayoutBorderSize = -1;

      mangoLayoutGapsOverride = -1;
      mangoLayoutRadiusOverride = -1;
      mangoLayoutBorderSize = -1;

      # Animations
      animationSpeed = 1;
      customAnimationDuration = 500;
      syncComponentAnimationSpeeds = true;
      popoutAnimationSpeed = 1;
      popoutCustomAnimationDuration = 150;
      modalAnimationSpeed = 1;
      modalCustomAnimationDuration = 150;
      enableRippleEffects = true;

      # Blur
      blurEnabled = false;
      blurForegroundLayers = true;
      blurLayerOutlineOpacity = 0.12;
      blurBorderColor = "outline";
      blurBorderCustomColor = "#ffffff";
      blurBorderOpacity = 0.35;
      wallpaperFillMode = "Fill";
      blurredWallpaperLayer = false;
      blurWallpaperOnOverview = false;

      # Clock
      use24HourClock = true;
      showSeconds = false;
      padHours12Hour = false;
      clockDateFormat = "dddd - dd/MM/yyyy";
      lockDateFormat = "";
      clockCompactMode = false;

      # Units / locale
      useFahrenheit = false;
      windSpeedUnit = "kmh";

      # Fonts
      fontFamily = "JetBrainsMonoNL Nerd Font";
      monoFontFamily = "JetBrainsMonoNL Nerd Font Mono";
      fontWeight = 400;
      fontScale = 1;

      # Notepad
      notepadUseMonospace = false;
      notepadFontFamily = "";
      notepadFontSize = 14;
      notepadShowLineNumbers = false;
      notepadTransparencyOverride = -1;
      notepadLastCustomTransparency = 0.7;

      # Icon
      iconTheme = "System Default";
      networkPreference = "auto";

      cursorSettings = {
        theme = "macOS-White";
        size = 24;
        niri = {
          hideWhenTyping = false;
          hideAfterInactiveMs = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        dwl = {
          cursorHideTimeout = 0;
        };
      };

      launcherLogoMode = "apps";
      launcherLogoCustomPath = "";
      launcherLogoColorOverride = "";
      launcherLogoColorInvertOnMode = false;
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;
      launcherLogoSizeOffset = 0;

      appLauncherViewMode = "list";
      appLauncherGridColumns = 4;
      spotlightModalViewMode = "list";
      spotlightCloseNiriOverview = true;
      appPickerViewMode = "grid";
      browserPickerViewMode = "grid";
      sortAppsAlphabetically = false;
      niriOverviewOverlayEnabled = true;

      dankLauncherV2Size = "compact";
      dankLauncherV2BorderEnabled = false;
      dankLauncherV2BorderThickness = 2;
      dankLauncherV2BorderColor = "primary";
      dankLauncherV2ShowFooter = true;
      dankLauncherV2UnloadOnClose = false;

      launcherPluginOrder = [];

      # Bar visibility widgets
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showWeather = true;
      showMusic = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = true;
      selectedGpuIndex = 0;
      enabledGpuPciIds = [];
      showSystemTray = true;
      showClock = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showCapsLockIndicator = true;
      showPrivacyButton = true;

      systemTrayIconTintMode = "none";
      systemTrayIconTintSaturation = 50;
      systemTrayIconTintStrength = 135;

      # Privacy button
      privacyShowMicIcon = true;
      privacyShowCameraIcon = true;
      privacyShowScreenShareIcon = true;

      # Control center
      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowAudioPercent = false;
      controlCenterShowVpnIcon = false;
      controlCenterShowBrightnessIcon = false;
      controlCenterShowBrightnessPercent = false;
      controlCenterShowMicIcon = false;
      controlCenterShowMicPercent = true;
      controlCenterShowBatteryIcon = false;
      controlCenterShowPrinterIcon = false;
      controlCenterShowScreenSharingIcon = true;

      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }
      ];

      # Workspace
      showWorkspaceIndex = true;
      showWorkspaceName = false;
      showWorkspacePadding = false;
      workspaceFollowFocus = true;
      workspaceScrolling = false;
      showOccupiedWorkspacesOnly = false;
      reverseScrolling = false;
      showWorkspaceApps = false;
      workspaceDragReorder = true;
      maxWorkspaceIcons = 3;
      workspaceAppIconSizeOffset = 0;
      groupWorkspaceApps = true;
      dwlShowAllTags = false;

      workspaceColorMode = "default";
      workspaceOccupiedColorMode = "none";
      workspaceUnfocusedColorMode = "default";
      workspaceUrgentColorMode = "default";

      workspaceFocusedBorderEnabled = false;
      workspaceFocusedBorderColor = "surfaceText";
      workspaceFocusedBorderThickness = 3;

      workspaceNameIcons = {};

      # Running apps / bar app widgets
      focusedWindowCompactMode = false;
      runningAppsCompactMode = true;
      barMaxVisibleApps = 0;
      barMaxVisibleRunningApps = 0;
      barShowOverflowBadge = true;
      runningAppsCurrentWorkspace = true;
      runningAppsGroupByApp = false;
      runningAppsCurrentMonitor = false;
      keyboardLayoutNameCompactMode = false;
      centeringMode = "index";

      # Dock (apps dock)
      showDock = false;
      dockAutoHide = false;
      dockSmartAutoHide = false;
      dockGroupByApp = false;
      dockOpenOnOverview = false;
      dockPosition = 1;
      dockSpacing = 4;
      dockBottomGap = 0;
      dockMargin = 0;
      dockIconSize = 40;
      dockIndicatorStyle = "circle";
      dockIsolateDisplays = false;

      dockBorderEnabled = false;
      dockBorderColor = "surfaceText";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;

      dockLauncherEnabled = false;
      dockLauncherLogoMode = "apps";
      dockLauncherLogoCustomPath = "";
      dockLauncherLogoColorOverride = "";
      dockLauncherLogoSizeOffset = 0;
      dockLauncherLogoBrightness = 0.5;
      dockLauncherLogoContrast = 1;

      dockMaxVisibleApps = 0;
      dockMaxVisibleRunningApps = 0;
      dockShowOverflowBadge = true;

      appsDockHideIndicators = false;
      appsDockColorizeActive = false;
      appsDockActiveColorMode = "primary";
      appsDockEnlargeOnHover = false;
      appsDockEnlargePercentage = 125;
      appsDockIconSizePercentage = 100;

      # Audio / media
      audioVisualizerEnabled = false;
      audioScrollMode = "volume";
      audioWheelScrollAmount = 10;
      scrollTitleEnabled = true;
      waveProgressEnabled = true;
      mediaSize = 1;

      # Sounds
      soundsEnabled = true;
      useSystemSoundTheme = false;
      soundNewNotification = true;
      soundVolumeChanged = true;
      soundPluggedIn = true;

      # Notifications
      notificationOverlayEnabled = true;
      notificationCompactMode = true;
      notificationPopupShadowEnabled = true;
      notificationPopupPrivacyMode = false;
      notificationPopupPosition = 0;
      notificationAnimationSpeed = 1;
      notificationCustomAnimationDuration = 400;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationTimeoutCritical = 0;

      notificationHistoryEnabled = true;
      notificationHistoryMaxCount = 50;
      notificationHistoryMaxAgeDays = 3;
      notificationHistorySaveLow = true;
      notificationHistorySaveNormal = true;
      notificationHistorySaveCritical = true;

      notificationRules = [];

      # OSD
      osdAlwaysShowValue = true;
      osdPosition = 7;
      osdVolumeEnabled = true;
      osdMediaVolumeEnabled = true;
      osdMediaPlaybackEnabled = false;
      osdBrightnessEnabled = true;
      osdIdleInhibitorEnabled = true;
      osdMicMuteEnabled = true;
      osdCapsLockEnabled = true;
      osdPowerProfileEnabled = true;
      osdAudioOutputEnabled = true;

      # Lock screen: core behaviour
      lockAtStartup = true;
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;
      lockScreenActiveMonitor = "all";
      lockScreenPowerOffMonitorsOnLock = false;
      lockScreenInactiveColor = "#000000";
      lockScreenNotificationMode = 2;
      hideBrightnessSlider = false;

      # Lock / DPMS transitions
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;

      # Lock screen: authentication
      enableFprint = true;
      maxFprintTries = 15;
      enableU2f = false;
      u2fMode = "or";

      # Lock screen: UI
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenShowMediaPlayer = true;

      # Greeter
      greeterEnableFprint = true;
      greeterEnableU2f = false;
      greeterRememberLastUser = true;
      greeterRememberLastSession = true;
      greeterWallpaperPath = "";

      # Power: AC
      acMonitorTimeout = 180;
      acLockTimeout = 180;
      acSuspendTimeout = 600;
      acSuspendBehavior = 2;
      acProfileName = "";

      # Power: battery
      batteryMonitorTimeout = 180;
      batteryLockTimeout = 180;
      batterySuspendTimeout = 300;
      batterySuspendBehavior = 2;
      batteryChargeLimit = 100;
      batteryProfileName = "";

      # Power menu
      powerActionConfirm = true;
      powerActionHoldDuration = 1;
      powerMenuDefaultAction = "logout";
      powerMenuGridLayout = false;
      powerMenuActions = [
        "reboot"
        "logout"
        "lock"
        "poweroff"
        "suspend"
        "restart"
        "hibernate"
      ];

      customPowerActionLock = "";
      customPowerActionLogout = "";
      customPowerActionSuspend = "";
      customPowerActionHibernate = "";
      customPowerActionReboot = "";
      customPowerActionPowerOff = "";

      # Theming integrations
      gtkThemingEnabled = false;
      qtThemingEnabled = false;
      terminalsAlwaysDark = false;

      # Terminal multiplexer
      muxType = "tmux";
      muxUseCustomCommand = false;
      muxCustomCommand = "";
      muxSessionFilter = "";

      # Clipboard
      clipboardEnterToPaste = false;

      # Updater
      updaterHideWidget = true;
      updaterUseCustomCommand = false;
      updaterCustomCommand = "";
      updaterTerminalAdditionalParams = "";

      # Display
      displayNameMode = "system";
      displayProfileAutoSelect = false;
      displayShowDisconnected = false;
      displaySnapToEdge = false;

      screenPreferences = {
        wallpaper = ["all"];
        dock = [];
        notepad = [];
      };

      showOnLastDisplay.dock = false;

      # Desktop clock widget
      desktopClockEnabled = false;
      desktopClockStyle = "analog";
      desktopClockTransparency = 0.8;
      desktopClockColorMode = "primary";
      desktopClockShowDate = true;
      desktopClockShowAnalogNumbers = false;
      desktopClockShowAnalogSeconds = true;
      desktopClockX = -1;
      desktopClockY = -1;
      desktopClockWidth = 280;
      desktopClockHeight = 180;
      desktopClockDisplayPreferences = ["all"];

      # System monitor widget
      systemMonitorEnabled = false;
      systemMonitorShowHeader = true;
      systemMonitorTransparency = 0.8;
      systemMonitorColorMode = "primary";
      systemMonitorShowCpu = true;
      systemMonitorShowCpuGraph = true;
      systemMonitorShowCpuTemp = true;
      systemMonitorShowGpuTemp = false;
      systemMonitorGpuPciId = "";
      systemMonitorShowMemory = true;
      systemMonitorShowMemoryGraph = true;
      systemMonitorShowNetwork = true;
      systemMonitorShowNetworkGraph = true;
      systemMonitorShowDisk = true;
      systemMonitorShowTopProcesses = false;
      systemMonitorTopProcessCount = 3;
      systemMonitorTopProcessSortBy = "cpu";
      systemMonitorGraphInterval = 60;
      systemMonitorLayoutMode = "auto";
      systemMonitorX = -1;
      systemMonitorY = -1;
      systemMonitorWidth = 320;
      systemMonitorHeight = 480;
      systemMonitorDisplayPreferences = ["all"];
      systemMonitorVariants = [];

      # Desktop widget instances / groups
      desktopWidgetInstances = [];
      desktopWidgetGroups = [];

      # Misc
      appIdSubstitutions = [];
      weatherEnabled = false;
      useAutoLocation = false;
      launchPrefix = "";

      # Bar
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;

          screenPreferences = ["all"];
          showOnLastDisplay = true;

          leftWidgets = ["workspaceSwitcher"];

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

      # Built-in plugins
      builtInPluginSettings = {
        dms_settings_search.enabled = false;
        dms_settings.enabled = false;
        dms_notepad.enabled = false;
        dms_sysmon.enabled = false;
      };
    };
  };
}
