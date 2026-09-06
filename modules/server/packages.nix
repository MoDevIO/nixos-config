{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.nixos-container ];
  programs.git.enable = true;
  programs.nh.enable = true;
}
