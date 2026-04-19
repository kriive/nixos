{ ... }:
{
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "7877ce3072584b48ab2d3b56a5d44d60";
      theme = "default";
      playback_window_position = "Top";
      enable_notify = false;
      copy_command = {
        command = "wl-copy";
        args = [ ];
      };
      device = {
        audio_cache = false;
        normalization = false;
      };
    };
  };
}
