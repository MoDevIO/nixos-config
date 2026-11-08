{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };
  sops.secrets."paperless-ngx/admin-password" = { };

  containers.paperless-ngx = {
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
        containerIpAddr = "192.168.179.122";
      };

      networking.hostName = "paperless-ngx";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.paperless = {
        enable = true;
        address = "0.0.0.0";
        port = 8000;
        mediaDir = "/var/lib/paperless-ngx/media";
        dataDir = "/var/lib/paperless-ngx/data";
        passwordFile = "/run/secrets/paperless-ngx/admin-password";
      };
    };
  };
}
