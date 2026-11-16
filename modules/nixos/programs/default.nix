{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./mpv.nix
    ./git.nix
    ./terminal.nix
    ./nautilus.nix
    ./neovim.nix
    ./vscode.nix
    ./qylock.nix
    ./fractal.nix
    ./opentofu.nix
    ./appimage.nix
    ./devtools.nix
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];
}
