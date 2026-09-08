{ config, ... }:

{
  sops.secrets."server_password" = { };

  users.users."admin" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."server_password".path;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets."server_password".path;
}
