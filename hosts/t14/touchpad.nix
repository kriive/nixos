{ config, ... }:
let
  testedKernelVersion = "7.2.9";
in
{
  assertions = [
    {
      assertion = config.boot.kernelPackages.kernel.version == testedKernelVersion;
      message = "T14 touchpad patches need review for this kernel. Build .#t14-kernel and update testedKernelVersion in hosts/t14/touchpad.nix after validation; see docs/workarounds.md.";
    }
  ];

  # Local carry from orospakr/thinkpad-t14-amd-touchpad at 03cdbb1857f5b9a6fbcef52a0f982d56edb99f5f
  # (pristine driver sources: Linux v7.2.3). Revisit when kernel patches land upstream.
  boot.kernelPatches = [
    {
      name = "t14-amd-asf-smbus-host-notify";
      patch = ./kernel-patches/0001-i2c-piix4-add-SMBus-Host-Notify-through-the-ASF-target-block-on-SMB0001-platforms.patch;
    }
    {
      name = "t14-amd-rmi-smbus-resume-settle";
      patch = ./kernel-patches/0002-Input-synaptics-rmi4-let-the-device-settle-after-the-PS2-reset-on-SMBus-resume.patch;
    }
    {
      name = "t14-amd-synaptics-rmi-doze-interval";
      patch = ./kernel-patches/0003-Input-synaptics-set-the-RMI4-doze-interval-Windows-uses-on-affected-ThinkPads.patch;
    }
    {
      name = "t14-amd-synaptics-intertouch-len2073";
      patch = ./kernel-patches/0004-Input-synaptics-enable-InterTouch-on-the-ThinkPad-T14-P14s-Gen-2-AMD.patch;
    }
  ];

  boot.initrd.kernelModules = [ "rmi_smbus" ];
}
