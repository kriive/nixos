{ ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      ao = "pipewire";
      hwdec = "auto";
      gpu-context = "wayland";
      hwdec-codecs = "all";
      profile = "gpu-hq";
    };
  };
}
