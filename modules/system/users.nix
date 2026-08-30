{ config, nixcord, ... }:

{

  sops.secrets."user_password_mo" = { };

  users.users."mo" = {
    isNormalUser = true;
    description = "Mo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."user_password_mo".path;
  };

  home-manager = {
    backupFileExtension = "backup";

    useGlobalPkgs = true;
    useUserPackages = true;

    users.mo.imports = [
      ../../home
      nixcord.homeModules.nixcord
    ];

  };
}
