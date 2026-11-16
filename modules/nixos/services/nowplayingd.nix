{ config, ... }:

{
  sops.secrets."homeassistant-token" = {
    owner = "mo";
  };

  services.nowplayingd = {
    enable = true;
    url = "https://ha.tilt.mn";
    app_psw_file = config.sops.secrets."homeassistant-token".path;
    daemon = true;
  };
}
