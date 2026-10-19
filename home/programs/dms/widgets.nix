{
  programs.dank-material-shell.settings = {
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
  };
}
