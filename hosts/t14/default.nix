{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/services
    ../../modules/desktop/gnome.nix
    ../../modules/programs
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
