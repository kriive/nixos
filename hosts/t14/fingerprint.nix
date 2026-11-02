{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.fprintd.enable = true;

  security.pam.services = {
    # greetd uses the login stack; keep its password available to GNOME Keyring.
    login.fprintAuth = false;
  }
  // lib.genAttrs [ "sudo" "sudo-i" ] (service: {
    rules.auth.lid-open = {
      # Skip fingerprint authentication unless the lid is open.
      order = config.security.pam.services.${service}.rules.auth.fprintd.order - 1;
      control = "[success=ignore default=1]";
      modulePath = "${config.security.pam.package}/lib/security/pam_exec.so";
      args = [
        "quiet"
        "${pkgs.gnugrep}/bin/grep"
        "-qw"
        "open"
        "/proc/acpi/button/lid/LID/state"
      ];
    };
  });
}
