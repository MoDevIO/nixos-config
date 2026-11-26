{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  containers.worker01 = {
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
        containerIpAddr = "192.168.179.160";
      };

      networking.hostName = "worker-01";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      users.users.root.linger = true;

      programs.tmux = {
        enable = true;
      };
    };
  };
}
