{
  imports = [
    ./hyprland/hyprland.nix
    ./kitty/kitty.nix
    ./nvim/nvim.nix
    ./firefox/firefox.nix
    ./neomutt/neomutt.nix
    ./vscode/vscode.nix
    ./git/git.nix
    ./system/dark-mode.nix
    ./system/mouse-cursor.nix
    ./nixcord/nixcord.nix
  ];

  home.stateVersion = "26.05";
}
