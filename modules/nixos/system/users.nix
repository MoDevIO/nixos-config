{
  self,
  config,
  nixcord,
  username,
  ...
}:

{

  sops.secrets."user_password_${username}" = { };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."user_password_${username}".path;
  };

  home-manager = {
    backupFileExtension = "backup";

    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username}.imports = [
      "${self}/modules/home-manager/default.nix"
      nixcord.homeModules.nixcord
    ];

  };
}
