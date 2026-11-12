{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    mouse = true;
    disableConfirmationPrompt = true;

    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"

      unbind r
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      bind-key -r h select-pane -L
      bind-key -r j select-pane -D
      bind-key -r k select-pane -U
      bind-key -r l select-pane -R
    '';
  };
}
