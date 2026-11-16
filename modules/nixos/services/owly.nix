{ inputs, ... }:

{
  hardware.usb-modeswitch.enable = true;

  imports = [ inputs.owly.nixosModules.default ];
  services.owly.enable = true;
  services.owly.settings = {
    allow_untested = true;
    station = "wlp51s0f4u1";
    channels = [ 6 ];
  };

  systemd.user.services.owly-radio = {
    description = "Owly AirDrop radio";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/owly radio up";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
