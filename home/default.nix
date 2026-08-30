{

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/home/mo/.config/sops/age/keys.txt";

  imports = [
    ./hyprland/hyprland.nix
    ./terminal
    ./nvim/nvim.nix
    ./firefox/firefox.nix
    ./wiremix/wiremix.nix
    ./cliamp/cliamp.nix
    ./neomutt/neomutt.nix
    ./vscode/vscode.nix
    ./git/git.nix
    ./syncthing/syncthing.nix
    ./system/dark-mode.nix
    ./system/mouse-cursor.nix
    ./nixcord/nixcord.nix
    ./opencode/opencode.nix
    ./nautilus/nautilus.nix
  ];

  home.stateVersion = "26.05";
}
