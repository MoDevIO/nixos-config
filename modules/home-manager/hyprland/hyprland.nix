{
  pkgs,
  keyboardLayout,
  hostname,
  ...
}:

{
  imports = [
    ./background.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings.config.input.kb_layout = keyboardLayout;

    extraConfig = ''
      hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
      hl.env("HYPRCURSOR_SIZE", "24")

      require("workspaces")
      require("keybinds")
      require("appearance")
      require("autostart")
      require("input")
      require("gkeys")

      ${
        if hostname == "T14" then
          ''require("monitors.t14")''
        else if hostname == "mopc" then
          ''require("monitors.mopc")''
        else
          ""
      }

    '';
  };

  home.packages = with pkgs; [
    awww

    # Screenshot
    grim
    slurp
    tesseract

    wl-clipboard
  ];

  xdg.configFile."hypr/workspaces.lua".source = ./lua/workspaces.lua;
  xdg.configFile."hypr/keybinds.lua".source = ./lua/keybinds.lua;
  xdg.configFile."hypr/appearance.lua".source = ./lua/appearance.lua;
  xdg.configFile."hypr/autostart.lua".source = ./lua/autostart.lua;
  xdg.configFile."hypr/input.lua".source = ./lua/input.lua;
  xdg.configFile."hypr/gkeys.lua".source = ./lua/gkeys.lua;
  xdg.configFile."hypr/monitors/t14.lua".source = ./lua/monitors/t14.lua;
  xdg.configFile."hypr/monitors/mopc.lua".source = ./lua/monitors/mopc.lua;

  programs.quickshell = {
    enable = true;

    systemd.enable = true;
    systemd.target = "hyprland-session.target";
  };
  # xdg.configFile."quickshell" = {
  #   source = ./quickshell;
  #   recursive = true;
  # };

  services.swaync.enable = true;
}
