let
  widget = id: {
    inherit id;
    enabled = true;
  };
  controlWidget =
    id:
    widget id
    // {
      w = 4;
      h = 1;
    };
  controlButton =
    id:
    controlWidget id
    // {
      w = 1;
      small = true;
    };
in
{
  programs.dank-material-shell.settings = {
    # DockConfig.normalize supplies the remaining fields.
    dockConfigs = [
      {
        id = "dock";
        name = "Dock";
        enabled = false;
        iconSize = 40;
        spacing = 4;
        itemSpacing = 4;
        margin = 0;
        launcherEnabled = false;
        launcherLogoMode = "apps";
        launcherLogoContrast = 1;
      }
    ];
    controlCenterWidgets = [
      (controlWidget "user" // { w = 5; })
      (controlButton "settings")
      (controlButton "lock")
      (controlButton "power")
    ]
    ++ map controlWidget [
      "volumeSlider"
      "brightnessSlider"
      "wifi"
      "bluetooth"
      "audioOutput"
      "audioInput"
      "nightMode"
      "darkMode"
      "builtin_tailscale"
      "idleInhibitor"
    ]
    ++ [
      # Schema 41 represents the old footer as positioned grid widgets.
      (
        controlWidget "runningApps"
        // {
          small = true;
          col = 0;
          row = 6;
        }
      )
      (
        controlButton "edit"
        // {
          col = 7;
          row = 6;
        }
      )
    ];
    # Restore this style when connected-frame mode is switched off.
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
        centerWidgets = map widget [
          "music"
          "clock"
          "weather"
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
        leftWidgets = map widget [
          "launcherButton"
          "workspaceSwitcher"
          "focusedWindow"
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
        rightWidgets =
          (map widget [
            "systemTray"
            "notificationButton"
            "battery"
          ])
          ++ [
            (widget "controlCenterButton" // { showMicPercent = true; })
          ];
        screenPreferences = [
          "all"
        ];
        scrollEnabled = true;
        scrollXBehavior = "focusWindow";
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
        widgetFollowInterfaceStyle = true;
      }
    ];
  };
}
