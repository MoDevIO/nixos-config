{
  self,
  config,
  pkgs,
  nixcord,
  username,
  ...
}:

{

  sops.secrets."user_password_${username}" = {
    neededForUsers = true;
  };

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
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
