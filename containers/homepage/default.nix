{
  self,
  config,
  prefixLength,
  ipAddr,
  ...
}:

{
  sops.secrets."tailscale_auth_key" = { };
  sops.secrets."homepage/homeassistant-token" = { };
  sops.secrets."homepage/jellyfin-key" = { };
  sops.secrets."homepage/navidrome-user" = { };
  sops.secrets."homepage/navidrome-token" = { };
  sops.secrets."homepage/navidrome-salt" = { };
  sops.secrets."homepage/immich-key" = { };
  sops.secrets."homepage/authentik-token" = { };

  sops.templates."homepage.env".content = ''
    HOMEPAGE_VAR_HA_TOKEN=${config.sops.placeholder."homepage/homeassistant-token"}
    HOMEPAGE_VAR_JELLYFIN_KEY=${config.sops.placeholder."homepage/jellyfin-key"}
    HOMEPAGE_VAR_NAVIDROME_USER=${config.sops.placeholder."homepage/navidrome-user"}
    HOMEPAGE_VAR_NAVIDROME_TOKEN=${config.sops.placeholder."homepage/navidrome-token"}
    HOMEPAGE_VAR_NAVIDROME_SALT=${config.sops.placeholder."homepage/navidrome-salt"}
    HOMEPAGE_VAR_IMMICH_KEY=${config.sops.placeholder."homepage/immich-key"}
    HOMEPAGE_VAR_AUTHENTIK_TOKEN=${config.sops.placeholder."homepage/authentik-token"}
  '';

  containers.homepage = {
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
        containerIpAddr = "192.168.179.130";
      };

      networking.hostName = "homepage";

      services.tailscale = {
        enable = true;
        authKeyFile = "/run/secrets/tailscale_auth_key";
      };

      networking.firewall.enable = false;

      services.homepage-dashboard = {
        enable = true;
        environmentFile = "/run/secrets/rendered/homepage.env";
        settings = {
          title = "tilt.mn Dashboard";
          theme = "dark";
          color = "slate";
        };
        listenPort = 8082;

        allowedHosts = "homepage:8082,home.tilt.mn";

        services = [
          {
            "Home" = [
              {
                "Home Assistant" = {
                  href = "https://ha.tilt.mn";
                  description = "Smart home";
                  siteMonitor = "http://homeassistant:8123";
                  statusStyle = "dot";

                  widget = {
                    type = "homeassistant";
                    url = "http://homeassistant:8123";
                    key = "{{HOMEPAGE_VAR_HA_TOKEN}}";
                    custom = [
                      {
                        template = "{{ state_attr('update.home_assistant_operating_system_update', 'installed_version') }}";
                        label = "version";
                      }
                      {
                        template = "{{ states | count }}";
                        label = "entities";
                      }
                      {
                        template = "{{ states | map(attribute='entity_id') | map('device_id') | reject('none') | unique | list | count }}";
                        label = "devices";
                      }
                      {
                        template = "{% set d = now() - states('sensor.uptime') | as_datetime %}{{ d.days }}d {{ d.seconds // 3600 }}h";
                        label = "uptime";
                      }
                    ];
                  };
                };
              }
            ];
          }

          {
            "Media" = [
              {
                "Jellyfin" = {
                  href = "https://movies.tilt.mn";
                  description = "Media server";
                  siteMonitor = "http://jellyfin:8096";
                  statusStyle = "dot";

                  widget = {
                    type = "jellyfin";
                    version = 2;
                    url = "http://jellyfin:8096";
                    key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
                    enableBlocks = true;
                    enableNowPlaying = true;
                    fields = [
                      "movies"
                      "series"
                      "episodes"
                    ];
                  };
                };
              }

              {
                "Navidrome" = {
                  href = "https://music.tilt.mn";
                  description = "Music";
                  siteMonitor = "http://navidrome:4533";
                  statusStyle = "dot";

                  widgets = [
                    {
                      type = "customapi";
                      url = "http://navidrome:4533/rest/getScanStatus?u={{HOMEPAGE_VAR_NAVIDROME_USER}}&t={{HOMEPAGE_VAR_NAVIDROME_TOKEN}}&s={{HOMEPAGE_VAR_NAVIDROME_SALT}}&v=1.16.1&c=homepage&f=json";
                      refreshInterval = 3600000;
                      mappings = [
                        {
                          field = "subsonic-response.scanStatus.count";
                          label = "Songs";
                          format = "number";
                        }
                      ];
                    }
                    {
                      type = "navidrome";
                      url = "http://navidrome:4533";
                      user = "{{HOMEPAGE_VAR_NAVIDROME_USER}}";
                      token = "{{HOMEPAGE_VAR_NAVIDROME_TOKEN}}";
                      salt = "{{HOMEPAGE_VAR_NAVIDROME_SALT}}";
                    }
                  ];
                };
              }

              {
                "Immich" = {
                  href = "https://images.tilt.mn";
                  description = "Photos";
                  siteMonitor = "http://immich:2283";
                  statusStyle = "dot";

                  widget = {
                    type = "immich";
                    url = "http://immich:2283";
                    key = "{{HOMEPAGE_VAR_IMMICH_KEY}}";
                    version = 2;
                  };
                };
              }
            ];
          }

          {
            "Security" = [
              {
                "Authentik" = {
                  href = "https://auth.tilt.mn";
                  description = "Identity provider";
                  siteMonitor = "http://authentik:9000";
                  statusStyle = "dot";

                  widget = {
                    type = "authentik";
                    version = 2;
                    url = "http://authentik:9000";
                    key = "{{HOMEPAGE_VAR_AUTHENTIK_TOKEN}}";
                  };
                };
              }
            ];
          }
        ];
      };
    };
  };
}
