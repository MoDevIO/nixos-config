{ self, ... }:

{
  imports = [
    ./hardware-configuration.nix

    "${self}/modules/system"
    "${self}/modules/services"
    "${self}/modules/desktop/gnome.nix"
    "${self}/modules/programs"
    "${self}/modules/programs/games.nix"
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
