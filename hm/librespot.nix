{
  inputs,
  ...
}:

{
  imports = [
    inputs.go-librespot.homeManagerModules.default
  ];
  services.go-librespot = {
    enable = true;
    settings = {
      zeroconf_enabled = false;
      credentials = {
        type = "interactive";
      };
      device_name = "thinkpad";
      bitrate = 320;
      audio_backend = "pulseaudio";
    };
  };

}
