{ keyboardLayout, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    configType = "lua";

    settings = {
      monitor = {
        output = "eDP-1";
        mode = "1920x1200@60";
        position = "0x0";
        scale = 1.2;
      };
    };

    settings.config.input.kb_layout = keyboardLayout;

    extraConfig = ''
      hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
      hl.env("HYPRCURSOR_SIZE", "24")

      require("workspaces")
      require("keybinds")
      require("appearance")
    '';
  };

  xdg.configFile."hypr/workspaces.lua".source = ./lua/workspaces.lua;
  xdg.configFile."hypr/keybinds.lua".source = ./lua/keybinds.lua;
  xdg.configFile."hypr/appearance.lua".source = ./lua/appearance.lua;
}
