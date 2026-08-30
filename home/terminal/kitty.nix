{
  programs.kitty = {
    enable = true;

    autoThemeFiles = {
      dark = "everforest_dark_medium";
      light = "everforest_light_medium";
      noPreference = "everforest_dark_medium";
    };

    settings = {
      shell = "zsh";
      confirm_os_window_close = 0;

      scrollbar_track_opacity = 0;
      scrollbar_track_hover_opacity = 0;
      allow_remote_control = true;

      font_family = "JetBrainsMono Nerd Font";
      font_size = 13.5;
      disable_ligatures = false;

      enable_audio_bell = false;

      url_style = "underline";

      remember_window_size = false;
      window_padding_width = 25;

      cursor_trail = 1;
    };
  };
}
