{ username, ... }:

{

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  imports = [
    ./programs/CLI
    ./programs/GUI
    ./hyprland/hyprland.nix
    ./terminal
    ./system/color-scheme.nix
    ./system/mouse-cursor.nix
    ./syncthing/syncthing.nix
  ];

  home.stateVersion = "26.05";
}
