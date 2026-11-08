{ self, config, ... }:

{
  imports = [
    ./hardware-configuration.nix

    "${self}/modules/nixos/system"
    "${self}/modules/nixos/services"
    "${self}/modules/nixos/desktop/hyprland.nix"
    "${self}/modules/nixos/programs"
    "${self}/modules/nixos/programs/games.nix"
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
