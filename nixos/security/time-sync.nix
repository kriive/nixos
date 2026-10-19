{ pkgs, ... }:
{
  # The maximum preset still enables this deprecated extra. Use the local policy
  # below; null disables the extra without retaining its deprecation warning.
  nix-mineral.extras.system.secure-chrony = null;

  services.chrony = {
    enable = true;
    extraFlags = [
      "-F 1"
      "-r"
    ];
    enableRTCTrimming = false;
    # Keep explicit server directives: NixOS interprets hostnames containing
    # "pool" as pools, including the individual server ntppool1.time.nl.
    servers = [ ];
    makestep.threshold = 1.0;
    extraConfig = ''
      server time.cloudflare.com iburst nts
      server ntppool1.time.nl iburst nts
      server nts.netnod.se iburst nts
      server ptbtime1.ptb.de iburst nts
      server time.dfm.dk iburst nts
      server time.cifelli.xyz iburst nts

      minsources 3
      authselectmode require
      dscp 46
      driftfile /var/lib/chrony/drift
      dumpdir /var/lib/chrony
      ntsdumpdir /var/lib/chrony
      leapseclist ${pkgs.tzdata}/share/zoneinfo/leap-seconds.list
      rtconutc
      rtcsync
      cmdport 0
      noclientlog
    '';
  };
}
