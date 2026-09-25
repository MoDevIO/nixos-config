{
  self,
  pkgs,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  containers.feishin = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    enableTun = true;

    extraFlags = [
      "--system-call-filter=bpf"
      "--system-call-filter=@keyring"
    ];

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
        containerIpAddr = "192.168.179.109";
      };

      networking.hostName = "feishin";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      virtualisation.oci-containers.containers.feishin = {
        image = "ghcr.io/jeffvli/feishin:latest";
        ports = [ "9180:9180" ];
        environment = {
          SERVER_NAME = "Navidrome";
          SERVER_TYPE = "navidrome";
          SERVER_URL = "https://navidrome.modevio.xyz";
          SERVER_LOCK = "false";
        };
      };

    };
  };
}
