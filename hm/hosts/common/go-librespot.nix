{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.go-librespot.homeManagerModules.default
  ];
  services.go-librespot = {
    enable = true;
    package = inputs.go-librespot.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      zeroconf_enabled = false;
      credentials = {
        type = "interactive";
      };
      device_name = "thinkpad";
      bitrate = 320;
      audio_backend = "pulseaudio";
      mpris_enabled = true;
    };
  };

}
