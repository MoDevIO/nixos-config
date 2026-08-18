{ config, ... }:

{
  services.syncthing = {
    enable = false;
    folders = {
      "Documents" = {
        label = "Documents";
        path = "/home/${config.home.homeDirectory}/Documents";
      };
    };
  };
}
