{
  inputs,
  pkgs,
  config,
  ...
}:

{
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "compose:menu,lv3:ralt_switch";
    };
    input.touchpad = {
      tap = true;
      dwt = true;
      natural-scroll = true;
      click-method = "clickfinger";
    };
    input.warp-mouse-to-focus = true;
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;
  };
}
