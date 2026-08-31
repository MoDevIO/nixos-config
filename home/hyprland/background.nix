{ lib, ... }:

{
  wayland.windowManager.hyprland.settings.on = {
    _args = [
      "hyprland.start"
      (lib.generators.mkLuaInline ''
        function()
          hl.exec_cmd("awww-daemon")
          hl.exec_cmd("sleep 1 && awww img /home/mo/.config/hypr/background.jpg")
        end
      '')
    ];
  };

  xdg.configFile."hypr/background.jpg".source = ./background.jpg;
}
