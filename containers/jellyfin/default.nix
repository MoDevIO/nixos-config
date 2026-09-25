{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/6416-D0CD";
    fsType = "exfat";
  };

  containers.jellyfin = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    enableTun = true;

    bindMounts = {
      "/run/secrets" = {
        hostPath = "/run/secrets";
        isReadOnly = true;
      };

      "/media" = {
        hostPath = "/mnt/media";
        isReadOnly = true;
      };

      "/media-2" = {
        hostPath = "/media-2";
        isReadOnly = true;
      };
    };

    config = {
      imports = [
        "${self}/modules/server/container-networking.nix"
      ];
      _module.args = {
        inherit prefixLength ipAddr;
        containerIpAddr = "192.168.179.104";
      };

      networking.hostName = "jellyfin";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.jellyfin = {
        enable = true;
        configDir = "/var/lib/jellyfin/config";
        dataDir = "/var/lib/jellyfin/data";
      };
    };
  };
}
