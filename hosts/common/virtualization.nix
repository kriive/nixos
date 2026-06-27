{ lib, pkgs, ... }:

let
  incusPrlimit = pkgs.writeShellScriptBin "prlimit" ''
    qemu_img=0
    for arg in "$@"; do
      case "$arg" in
        qemu-img|*/qemu-img)
          qemu_img=1
          break
          ;;
      esac
    done

    if [ "$qemu_img" -eq 1 ] && [ -e /etc/ld-nix.so.preload ]; then
      exec ${pkgs.bubblewrap}/bin/bwrap \
        --dev-bind / / \
        --tmpfs /etc \
        ${pkgs.util-linux}/bin/prlimit "$@"
    fi

    exec ${pkgs.util-linux}/bin/prlimit "$@"
  '';
in
{
  boot.kernel.sysctl."kernel.dmesg_restrict" = lib.mkForce 1;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless.enable = lib.mkForce false;
  };

  virtualisation.incus = {
    enable = true;
    package = pkgs.incus-lts;

    preseed = {
      networks = [
        {
          name = "incusbr0";
          type = "bridge";
          config = {
            "ipv4.address" = "auto";
            "ipv4.nat" = "true";
            "ipv6.address" = "auto";
            "ipv6.nat" = "true";
          };
        }
      ];

      profiles = [
        {
          name = "default";
          devices = {
            eth0 = {
              name = "eth0";
              network = "incusbr0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              type = "disk";
            };
          };
        }
      ];

      storage_pools = [
        {
          name = "default";
          driver = "dir";
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
        }
      ];
    };
  };

  systemd.services.incus.path = lib.mkBefore [ incusPrlimit ];

}
