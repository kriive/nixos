{
  currentThemeName = "dynamic";
  clockFormat = "24h";
  blurBorderOpacity = 0.14;
  wallpaperBackgroundColorMode = "surface";
  monoFontFamily = "TX02 Nerd Font";
  dockConfigs = [
    {
      id = "dock";
      name = "Dock";
      enabled = false;
      screenPreferences = [
        "all"
      ];
      showOnLastDisplay = true;
      position = 1;
      mode = "compact";
      taskbarAlign = "center";
      widgetExpansion = "popout";
      iconSize = 40;
      spacing = 4;
      itemSpacing = 4;
      margin = 0;
      bottomGap = 0;
      transparency = 1;
      followInterfaceStyle = true;
      autoHide = false;
      smartAutoHide = false;
      useOverlayLayer = false;
      editOnRightClick = false;
      showOnFullscreen = false;
      openOnOverview = false;
      groupByApp = false;
      separatePinnedAndRunningApps = false;
      restoreSpecialWorkspaceOnClick = false;
      isolateDisplays = false;
      indicatorStyle = "circle";
      borderEnabled = false;
      borderColor = "surfaceText";
      borderOpacity = 1;
      borderThickness = 1;
      launcherEnabled = false;
      launcherLogoMode = "apps";
      launcherLogoCustomPath = "";
      launcherLogoColorOverride = "";
      launcherLogoSizeOffset = 0;
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;
      maxVisibleApps = 0;
      maxVisibleRunningApps = 0;
      showOverflowBadge = true;
      showTrash = false;
      trashFileManager = "default";
      trashCustomCommand = "";
      order = [
      
      ];
      widgets = [
        {
          enabled = true;
          id = "dock_launcher";
          widgetId = "dockLauncher";
        }
        {
          enabled = true;
          id = "dock_apps";
          widgetId = "appsDock";
        }
        {
          enabled = true;
          id = "dock_trash";
          widgetId = "dockTrash";
        }
      ];
    }
  ];
  currentThemeCategory = "dynamic";
  matugenScheme = "scheme-content";
  matugenSourceMode = "colorful";
  matugenContrast = 0.54;
  matugenSpec = "2025";
  dmsWindowsFloatingSeeded = [
    "niri"
  ];
  niriLayoutGapsOverride = 15;
  niriLayoutRadiusOverride = 0;
  springBounce = 0;
  motionEffect = 3;
  blurredWallpaperLayer = true;
  blurWallpaperOnOverview = true;
  controlCenterWidgets = [
    {
      enabled = true;
      h = 1;
      id = "volumeSlider";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "brightnessSlider";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "wifi";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "bluetooth";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "audioOutput";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "audioInput";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "nightMode";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "darkMode";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "builtin_tailscale";
      w = 4;
    }
    {
      enabled = true;
      h = 1;
      id = "idleInhibitor";
      w = 4;
    }
  ];
  appIdSubstitutions = [
  
  ];
  dashOptions = {
    clock = {
      tone = "tertiary";
    };
    media = {
      animatedArt = true;
    };
    weather = {
      city = true;
      forecast = "cards";
    };
  };
  cursorSettings = {
    dwl = {
      cursorHideTimeout = 0;
    };
    hyprland = {
      hideOnKeyPress = false;
      hideOnTouch = false;
      inactiveTimeout = 0;
    };
    niri = {
      hideAfterInactiveMs = 0;
      hideWhenTyping = true;
    };
    size = 24;
    theme = "System Default";
  };
  acMonitorTimeout = 180;
  acLockTimeout = 900;
  acPostLockMonitorTimeout = 60;
  batteryMonitorTimeout = 300;
  batteryLockTimeout = 600;
  batterySuspendTimeout = 1800;
  batteryAutoPowerSaver = true;
  lockBeforeSuspend = true;
  muxType = "zellij";
  notificationPopupBodyInvokesAction = true;
  lockScreenNotificationMode = 2;
  osdAlwaysShowValue = true;
  osdPosition = 0;
  osdMediaPlaybackEnabled = true;
  osdPowerProfileEnabled = true;
  screenPreferences = {
    wallpaper = [
      "all"
    ];
  };
  connectedFrameBarStyleBackups = {
    default = {
      attachToScreenEdge = false;
      borderEnabled = false;
      gothCornersEnabled = false;
      shadowIntensity = 0;
      squareCorners = false;
    };
  };
  barConfigs = [
    {
      autoHide = false;
      autoHideDelay = 250;
      borderColor = "surfaceText";
      borderEnabled = false;
      borderOpacity = 1;
      borderThickness = 1;
      bottomGap = 0;
      centerWidgets = [
        {
          enabled = true;
          id = "music";
        }
        {
          enabled = true;
          id = "clock";
        }
        {
          enabled = true;
          id = "weather";
        }
      ];
      clickThrough = false;
      enabled = true;
      followInterfaceStyle = true;
      fontScale = 1;
      gothCornerRadiusOverride = false;
      gothCornerRadiusValue = 12;
      gothCornersEnabled = false;
      iconScale = 1;
      id = "default";
      innerPadding = 4;
      islandHighContrast = false;
      islandHomeCompactTight = false;
      islandPalette = "bright";
      leftWidgets = [
        {
          enabled = true;
          id = "launcherButton";
        }
        {
          enabled = true;
          id = "workspaceSwitcher";
        }
        {
          enabled = true;
          id = "focusedWindow";
        }
      ];
      maximizeDetection = true;
      maximizeWidgetIcons = false;
      maximizeWidgetText = false;
      name = "Main Bar";
      noBackground = false;
      openOnOverview = false;
      popupGapsAuto = true;
      popupGapsManual = 4;
      position = 0;
      rightWidgets = [
        {
          enabled = true;
          id = "systemTray";
        }
        {
          enabled = true;
          id = "notificationButton";
        }
        {
          enabled = true;
          id = "battery";
        }
        {
          enabled = true;
          id = "controlCenterButton";
          showMicPercent = true;
        }
      ];
      screenPreferences = [
        "all"
      ];
      scrollEnabled = true;
      scrollXBehavior = "column";
      scrollYBehavior = "workspace";
      shadowColorMode = "default";
      shadowCustomColor = "#000000";
      shadowIntensity = 0;
      shadowOpacity = 60;
      showOnLastDisplay = true;
      showOnWindowsOpen = false;
      spacing = 4;
      squareCorners = false;
      transparency = 1;
      visible = true;
      widgetOutlineColor = "primary";
      widgetOutlineEnabled = false;
      widgetOutlineOpacity = 1;
      widgetOutlineThickness = 1;
      widgetPadding = 8;
      widgetTransparency = 1;
    }
  ];
  desktopWidgetInstances = [
    {
      config = {
        colorMode = "primary";
        customColor = "#ffffff";
        displayPreferences = [
          "all"
        ];
        gpuPciId = "";
        graphInterval = 60;
        layoutMode = "auto";
        showCpu = true;
        showCpuGraph = true;
        showCpuTemp = true;
        showDisk = true;
        showGpuTemp = false;
        showHeader = true;
        showMemory = true;
        showMemoryGraph = true;
        showNetwork = true;
        showNetworkGraph = true;
        showTopProcesses = false;
        topProcessCount = 3;
        topProcessSortBy = "cpu";
        transparency = 0.8;
      };
      enabled = true;
      group = "dwg_1776458222808_aqy21bfez";
      id = "dw_1776458094612_cqwkfx4yu";
      name = "System Monitor";
      widgetType = "systemMonitor";
    }
    {
      config = {
        colorMode = "primary";
        customColor = "#ffffff";
        displayPreferences = [
          "all"
        ];
        showAnalogNumbers = false;
        showAnalogSeconds = true;
        showDate = true;
        style = "stacked";
        transparency = 0;
      };
      enabled = true;
      group = "dwg_1776458222808_aqy21bfez";
      id = "dw_1776458127963_mcb2f9zl4";
      name = "Desktop Clock";
      widgetType = "desktopClock";
    }
    {
      config = {
        clickThrough = false;
        displayPreferences = [
          "all"
        ];
        firstLineSize = 15;
        secondLineSize = 10;
        showOnOverlay = false;
      };
      enabled = true;
      id = "dw_1783460459861_8z9nperrz";
      name = "Activate Linux Watermark";
      widgetType = "activateLinux";
    }
  ];
  desktopWidgetGroups = [
    {
      collapsed = false;
      id = "dwg_1776458222808_aqy21bfez";
      name = "Main";
    }
  ];
  builtInPluginSettings = {
    dms_clipboard_search = {
      trigger = "cb";
    };
    dms_power = {
      trigger = "pw";
    };
    dms_qr_generator = {
      trigger = "qrg";
    };
    dms_settings_search = {
      trigger = "?";
    };
  };
  frameEnabled = true;
  frameThickness = 2;
  frameShowOnOverview = true;
  frameCloseGaps = false;
  configVersion = 30;
}
