{
  imports = [
    ./appearance.nix
    ./bars.nix
    ./widgets.nix
    ./power.nix
  ];

  programs.dank-material-shell.settings = {
    # Prevent DMS from regenerating compositor rules at startup.
    dmsWindowsFloatingSeeded = [
      "niri"
    ];
    # Override the nonempty upstream substitutions list.
    appIdSubstitutions = [ ];
    networkPreference = "wifi";
    muxType = "zellij";
    notificationPopupBodyInvokesAction = true;
    osdAlwaysShowValue = true;
    osdPosition = 0;
    osdMediaPlaybackEnabled = true;
    osdPowerProfileEnabled = true;
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
    # Matches the declared settings and the pinned DMS schema.
    configVersion = 42;
  };
}
