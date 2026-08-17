{ config, hostname, ... }:

{
    networking.hostName = hostname;
    networking.firewall.enable = false;

    sops.secrets."wifi_secrets" = {
        owner = "root";
    };

    networking.networkmanager = {
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

}