{ ... }:

{
  niri = {
    settings = {
      binds = {
        "Mod+Return".action.spawn = "foot";
        "Mod+space".action.spawn = 'tofi-drun "--drun-launch=true"';
        "Mod+Q".action.close-window = true;
        "Mod+Left" = { focus-column-left };
        "Mod+Down" = { focus-window-down };
        "Mod+Up"   = { focus-window-up };
        "Mod+Right"= { focus-column-right };
        "Mod+H"    ={ focus-column-left };
        "Mod+J"    ={ focus-window-down };
        "Mod+K"    ={ focus-window-up };
        "Mod+L"    ={ focus-column-right };
      };
    };
    package = pkgs.niri-unstable;
  };
}
