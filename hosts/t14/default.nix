{ self, ... }:

{
  imports = [
    ./hardware-configuration.nix

    "${self}/modules/nixos/system"
    "${self}/modules/nixos/services"
    "${self}/modules/nixos/desktop/hyprland.nix"
    "${self}/modules/nixos/desktop/gnome.nix"
    "${self}/modules/nixos/programs"
    "${self}/modules/nixos/programs/games.nix"
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
