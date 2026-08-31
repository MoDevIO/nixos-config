{ config, ... }:

{
  sops.secrets."syncthing_gui_password" = { };

  services.syncthing = {
    enable = true;

    guiCredentials.username = "admin";
    guiCredentials.passwordFile = "${config.sops.secrets."syncthing_gui_password".path}";

    settings = {
      folders = {
        "Documents" = {
          label = "Documents";
          path = "${config.home.homeDirectory}/Documents";
          devices = [ "introducer" ];
        };
      };

      devices = {
        "introducer" = {
          id = "SG3NPHY-NYYL2IN-IYOXXVN-UOQNPAY-JAHE4DL-MSL5V6V-KPKT5IZ-RNFMXAM";
          introducer = true;
          autoAcceptFolders = true;
        };
      };
    };
  };
}
