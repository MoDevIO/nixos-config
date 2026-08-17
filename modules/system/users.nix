{ nixcord, ... }:

{
  users.users."mo" = {
    isNormalUser = true;
    description = "Mo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {

    useGlobalPkgs = true;
    useUserPackages = true;

    users.mo.imports = [
      ../../home
      nixcord.homeModules.nixcord
    ];

  };
}
