{
  inputs,
  pkgs,
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  containers.ttyd = {
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

        inputs.home-manager.nixosModules.home-manager
      ];
      _module.args = {
        inherit prefixLength ipAddr;
        containerIpAddr = "192.168.179.111";
      };

      networking.hostName = "ttyd";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.ttyd = {
        enable = true;
        port = 7681;
        interface = "0.0.0.0";
        writeable = false;
        user = "ttyd";
        entrypoint = [ "${pkgs.zsh}/bin/zsh" ];
      };

      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        users.ttyd.imports = [
          "${self}/modules/home-manager/terminal/zsh.nix"
        ];
      };

      users.users.ttyd = {
        isSystemUser = true;
        description = "ttyd user";
        group = "ttyd";
        home = "/home/ttyd";
        createHome = true;
      };
      users.groups.ttyd = { };
    };
  };
}
