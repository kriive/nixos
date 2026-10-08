{
  # Local carry from orospakr/thinkpad-t14-amd-touchpad at 742c47e3730553d0546ad874deac006d9bec18c0
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
    {
      # Mainline 761c2040a7d4; drop once the selected kernel includes this fix.
      name = "psmouse-disconnect-use-after-free";
      patch = ./kernel-patches/0101-Input-psmouse-fix-use-after-free-during-protocol-disconnect.patch;
    }
  ];

  boot.initrd.kernelModules = [ "rmi_smbus" ];
}
