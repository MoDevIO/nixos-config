{ hostname, ... }:

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

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "arrow";
    };

    shellAliases = {
      # Git
      gi = "git init";
      ga = "git add";
      gc = "git commit";
      gca = "git commit --amend";
      gs = "git status";
      gp = "git push";
      gpl = "git pull";
      gcl = "git clone";
      gco = "git checkout";

      # Nix
      ns = "nix-shell -p";
      nd = "nix develop";
      nors = "sudo nixos-rebuild switch --flake ~/Documents/Coding/nix-config#" + hostname;
    };

    initContent = ''
      nvim() {
        kitty @ set-spacing padding=0
        command nvim "$@"
        kitty @ set-spacing padding=default
      }
    '';

  };

  programs.bash = {
    enable = true;

    shellAliases = {
      # Git
      gi = "git init";
      ga = "git add";
      gc = "git commit";
      gca = "git commit --amend";
      gs = "git status";
      gp = "git push";
      gpl = "git pull";
      gcl = "git clone";
      gco = "git checkout";

      # Nix
      ns = "nix-shell -p";
      nd = "nix develop";
      nors = "sudo nixos-rebuild switch --flake ~/Documents/Coding/nix-config#" + hostname;
    };
  };
}
