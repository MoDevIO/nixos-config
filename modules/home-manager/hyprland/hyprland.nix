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

  xdg.configFile."hypr" = {
    source = ./lua;
    recursive = true;
  };
}
