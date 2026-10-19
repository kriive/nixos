{
  boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Touchpad Pressure Override]
    MatchUdevType=touchpad
    MatchName=*Synaptics TM3512-010*
    AttrPressureRange=10:8
  '';
}
