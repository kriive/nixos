{ lib, ... }:
{
  # Preserve the additional restrictions from the former Kicksecure blacklist.
  # These names are not covered by the currently pinned nix-mineral module groups.
  # Use supported options instead of fetching and rewriting a second modprobe file.
  nix-mineral.kernel-modules.disable = lib.genAttrs [
    "garmin_gps"
    "pmt_class"
    "pmt_crashlog"
    "pmt_telemetry"
    "cifs_arc4"
    "nfsv2"
    "eepro100"
    "eth1394"
    "ueagle_atm"
    "c_can"
    "c_can_pci"
    "c_can_platform"
    "can_dev"
    "janz_ican3"
    "m_can_platform"
    "phy_can_transceiver"
    "ucan"
    "hamradio"
    "intel_wmi_thunderbolt"
  ] (_: true);
}
