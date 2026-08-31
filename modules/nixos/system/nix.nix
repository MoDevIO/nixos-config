{ pkgs, ... }:

{
  system.stateVersion = "26.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.brightnessctl
  ];
}
