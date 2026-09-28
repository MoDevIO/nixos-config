{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  containers.ollama = {
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
        containerIpAddr = "192.168.179.150";
      };

      networking.hostName = "ollama";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.ollama = {
        enable = true;
        loadModels = [
          "qwen2.5:14b"
        ];
        modelsDir = "/var/lib/ollama/models";
        host = "0.0.0.0";
        port = 11434;

        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "16384";
        };
      };
    };
  };
}
