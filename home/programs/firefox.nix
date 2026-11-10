{ config, pkgs, ... }:

let
  pywalfoxHost = pkgs.writeTextDir "lib/mozilla/native-messaging-hosts/pywalfox.json" (
    builtins.toJSON {
      name = "pywalfox";
      description = "Firefox theme synchronization";
      path = "${pkgs.pywalfox-native}/bin/pywalfox";
      type = "stdio";
      allowed_extensions = [ "pywalfox@frewacom.org" ];
    }
  );
in
{
  home.packages = [ pkgs.pywalfox-native ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    nativeMessagingHosts = [ pywalfoxHost ];
    policies.ExtensionSettings = {
      "pywalfox@frewacom.org" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      };
    };
  };

  programs.dank-material-shell.settings.matugenTemplatePywalfox = true;
}
