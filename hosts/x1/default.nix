{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/services
    ../../modules/desktop/gnome.nix
    ../../modules/programs
  ];
}
