{
  self,
  config,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };
  sops.secrets."navidrome_lastfm_api_key" = { };
  sops.secrets."navidrome_lastfm_secret" = { };

  sops.templates."navidrome-lastfm.env".content = ''
    ND_LASTFM_APIKEY=${config.sops.placeholder."navidrome_lastfm_api_key"}
    ND_LASTFM_SECRET=${config.sops.placeholder."navidrome_lastfm_secret"}
  '';

  containers.navidrome = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    enableTun = true;

    bindMounts = {
      "/run/secrets" = {
        hostPath = "/run/secrets";
        isReadOnly = true;
      };
      "/run/secrets-rendered" = {
        hostPath = "/run/secrets-rendered";
        isReadOnly = true;
      };
    };

    config = {
      imports = [
        "${self}/modules/server/container-networking.nix"
      ];
      _module.args = {
        inherit prefixLength ipAddr;
        containerIpAddr = "192.168.179.103";
      };

      networking.hostName = "navidrome";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.navidrome = {
        enable = true;
        environmentFile = "/run/secrets-rendered/navidrome-lastfm.env";
        settings = {
          Port = 4533;
          Address = "0.0.0.0";

          MusicFolder = "/var/lib/navidrome/music";
          DataFolder = "/var/lib/navidrome/data";

          LastFM.Enabled = true;
        };
      };
    };
  };
}
