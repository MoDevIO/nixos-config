{
  self,
  inputs,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };
  sops.secrets."authentik_env" = { };

  containers.authentik = {
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
        inputs.authentik-nix.nixosModules.default
      ];
      _module.args = {
        inherit prefixLength ipAddr;
        containerIpAddr = "192.168.179.110";
      };

      networking.hostName = "authentik";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.authentik = {
        enable = true;
        environmentFile = "/run/secrets/authentik_env";
        settings = {
          disable_startup_analytics = true;
          avatars = "initials";
        };
      };
    };
  };
}
