{
  config,
  hostname,
  ipAddr,
  prefixLength,
  networkInterface,
  ...
}:

{
  sops.secrets."wifi_secrets" = {
    owner = "root";
  };

  networking = {
    hostName = hostname;
    interfaces.${networkInterface}.ipv4.addresses = [
      {
        address = ipAddr;
        prefixLength = prefixLength;
      }
    ];

    firewall.enable = false;
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [
          config.sops.secrets."wifi_secrets".path
        ];

        profiles = {
          "superspeed" = {
            connection = {
              id = "superspeed";
              type = "wifi";
              autoconnect = true;
            };
            wifi = {
              ssid = "superspeed";
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$SUPERSPEED_PASSWORD";
            };
          };
        };
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
