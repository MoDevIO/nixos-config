{
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  containers.synapse = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";

    config = {
      imports = [
        "${self}/modules/server/container-networking.nix"
      ];
      _module.args = {
        inherit prefixLength ipAddr;
      };

      networking.firewall.enable = false;

      services.postgresql = {
        enable = true;
        initdbArgs = [
          "--locale=C"
          "--encoding=UTF8"
        ];

        ensureDatabases = [ "matrix-synapse" ];
        ensureUsers = [
          {
            name = "matrix-synapse";
            ensureDBOwnership = true;
          }
        ];
      };

      services.matrix-synapse = {
        enable = true;

        settings = {
          server_name = "motrix.click";

          listeners = [
            {
              port = 8008;
              bind_addresses = [ "0.0.0.0" ];
              type = "http"; # Production: https
              tls = false; # Production: true
              x_forwarded = false; # Production: true

              resources = [
                {
                  names = [ "client" ];
                  compress = true;
                }
              ];
            }
          ];
        };
      };
    };
  };
}
