{
  currentThemeName = "dynamic";
  currentThemeCategory = "dynamic";
  matugenScheme = "scheme-neutral";
  matugenContrast = 0.54;
  cornerRadius = 12;
  niriLayoutGapsOverride = 15;
  niriLayoutRadiusOverride = 0;
  clockFormat = "24h";
  blurBorderOpacity = 0.14;
  blurredWallpaperLayer = true;
  wallpaperBackgroundColorMode = "surface";
  controlCenterShowMicPercent = true;
  controlCenterWidgets = [
    {
      enabled = true;
      id = "volumeSlider";
      width = 50;
    }
    {
      enabled = true;
      id = "brightnessSlider";
      width = 50;
    }
    {
      enabled = true;
      id = "wifi";
      width = 50;
    }
    {
      enabled = true;
      id = "bluetooth";
      width = 50;
    }
    {
      enabled = true;
      id = "audioOutput";
      width = 50;
    }
    {
      enabled = true;
      id = "audioInput";
      width = 50;
    }
    {
      enabled = true;
      id = "nightMode";
      width = 50;
    }
    {
      enabled = true;
      id = "darkMode";
      width = 50;
    }
    {
      enabled = true;
      id = "builtin_tailscale";
      width = 50;
    }
    {
      enabled = true;
      id = "idleInhibitor";
      width = 50;
    }
  ];
  appIdSubstitutions = [
  
  ];
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
  lockScreenNotificationMode = 2;
  osdAlwaysShowValue = true;
  osdMediaPlaybackEnabled = true;
  osdPowerProfileEnabled = true;
  screenPreferences = {
    wallpaper = [
      "all"
    ];
  };
  connectedFrameBarStyleBackups = {
    default = {
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
      fontScale = 1;
      gothCornerRadiusOverride = false;
      gothCornerRadiusValue = 12;
      gothCornersEnabled = false;
      iconScale = 1;
      id = "default";
      innerPadding = 4;
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
      removeWidgetPadding = false;
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
  desktopClockCustomColor = {
    r = 1;
    g = 1;
    b = 1;
    a = 1;
    hsvHue = (-1);
    hsvSaturation = 0;
    hsvValue = 1;
    hslHue = (-1);
    hslSaturation = 0;
    hslLightness = 1;
    valid = true;
  };
  systemMonitorCustomColor = {
    r = 1;
    g = 1;
    b = 1;
    a = 1;
    hsvHue = (-1);
    hsvSaturation = 0;
    hsvValue = 1;
    hslHue = (-1);
    hslSaturation = 0;
    hslLightness = 1;
    valid = true;
  };
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
    dms_settings_search = {
      trigger = "?";
    };
  };
  frameEnabled = true;
  frameThickness = 2;
  frameShowOnOverview = true;
  frameCloseGaps = false;
  configVersion = 15;
}
