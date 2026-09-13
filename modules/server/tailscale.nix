{ config, ... }:

{
  sops.secrets."tailscale_auth_key" = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale_auth_key".path;
  };
}
