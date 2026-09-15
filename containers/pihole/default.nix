{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  containers.pihole = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    enableTun = true;

    bindMounts = {
      "/run/secrets" = {
        hostPath = "/run/secrets";
        isReadOnly = true;
      };
    };

    config = {
      imports = [
        "${self}/modules/server/container-networking.nix"
      ];
      _module.args = {
        inherit prefixLength ipAddr;
        containerIpAddr = "192.168.179.105";
      };

      networking.hostName = "pihole";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.pihole-ftl = {
        enable = true;
        lists = [
          {
            url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
            type = "block";
            enabled = true;
            description = "AdBlock and MalwareBlock";
          }
        ];
        settings = {
          port = 8080;
        };
      };
      services.pihole-web = {
        enable = true;
        ports = [ 8080 ];
      };
    };
  };
}
