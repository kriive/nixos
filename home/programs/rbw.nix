{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.rbw = {
    enable = true;
    settings = {
      email = "manuel.romei@outlook.it";
      pinentry = pkgs.pinentry-qt;
    };
  };

  xdg.configFile."rbw-havce/config.json".text = builtins.toJSON {
    email = "kriive@havce.it";
    base_url = "https://vault.havce.it";
    lock_timeout = 3600;
    sync_interval = 3600;
    pinentry = "${pkgs.pinentry-qt}/bin/pinentry";
  };

  systemd.user.services = lib.genAttrs [ "rbw-agent" "rbw-agent-havce" ] (name: {
    Unit = {
      Description = "Bitwarden agent (${name})";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "forking";
      Environment = [
        "RBW_PROFILE=${lib.optionalString (name == "rbw-agent-havce") "havce"}"
        "RBW_AGENT=${lib.getExe' config.programs.rbw.package "rbw-agent"}"
      ];
      # Start locked and give SSH-triggered pinentry the desktop display environment.
      ExecStart = "${lib.getExe config.programs.rbw.package} lock";
      ExecStop = "${lib.getExe config.programs.rbw.package} stop-agent";
      PIDFile = "%t/rbw${lib.optionalString (name == "rbw-agent-havce") "-havce"}/pidfile";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  });

  sshAuthSock = {
    enable = true;
    initialization = {
      bash = ''export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"'';
      fish = ''set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"'';
      nushell = ''$env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/rbw/ssh-agent-socket"'';
    };
    systemd.socketProviderUnit = "rbw-agent.service";
  };
}
