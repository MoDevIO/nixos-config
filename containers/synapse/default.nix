{
  config,
  self,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };

  sops.secrets."matrix/registration_shared_secret" = { };
  sops.secrets."matrix/telegram_api_hash" = { };
  sops.secrets."matrix/signal_pickle_key" = { };

  sops.templates."mautrix-telegram.env".content = ''
    MAUTRIX_TELEGRAM_TELEGRAM_API_HASH=${config.sops.placeholder."matrix/telegram_api_hash"}
  '';
  sops.templates."mautrix-signal.env".content = ''
    MAUTRIX_SIGNAL_ENCRYPTION_PICKLE_KEY=${config.sops.placeholder."matrix/signal_pickle_key"}
  '';

  containers.synapse = {
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
      };

      networking.hostName = "synapse";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      nixpkgs.config.permittedInsecurePackages = [
        "olm-3.2.16"
      ];

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

          registration_shared_secret = config.sops.secrets."matrix/registration_shared_secret".path;

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

      services.mautrix-discord = {
        enable = true;
        registerToSynapse = true;
        settings = {
          homeserver = {
            domain = "motrix.click";
            address = "http://localhost:8008";
          };
          bridge = {
            permissions."@mo:motrix.click" = "admin";

            encryption = {
              allow = true;
              default = true;
            };
          };
        };
      };

      services.mautrix-telegram = {
        enable = true;
        registerToSynapse = true;
        environmentFile = config.sops.templates."mautrix-telegram.env".path;
        settings = {
          telegram.api_id = 39985518;
          homeserver = {
            domain = "motrix.click";
            address = "http://localhost:8008";
          };

          bridge = {
            permissions."@mo:motrix.click" = "admin";

            encryption = {
              allow = true;
              default = true;
            };
          };
        };
      };

      services.mautrix-signal = {
        enable = true;
        registerToSynapse = true;
        environmentFile = config.sops.templates."mautrix-signal.env".path;
        settings = {
          homeserver = {
            domain = "motrix.click";
            address = "http://localhost:8008";
          };

          encryption = {
            allow = true;
            default = true;
            pickle_key = "$MAUTRIX_SIGNAL_ENCRYPTION_PICKLE_KEY";
          };

          bridge = {
            permissions."@mo:motrix.click" = "admin";
          };
        };
      };
    };
  };
}
