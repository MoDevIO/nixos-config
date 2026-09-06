{ config, ... }:

{
  sops.secrets."hashed_password" = { };

  users.users."admin" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."hashed_password".path;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets."hashed_password".path;
}
