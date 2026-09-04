{ systemName, ... }:

{
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
      nors = "nh os switch ~/nixos-config#" + systemName;

      # nvim
      nvimnix = "cd ~/nixos-config && nvim .";

      # Quick folder navigation
      cdh = "cd ~";
      cdd = "cd ~/Documents";
      cdcd = "cd ~/Documents/Coding";
      cdn = "cd ~/nixos-config";

      # Other
      ssh = "TERM=xterm-256color ssh";
      ndd = "nautilus . & disown; kitty @ close-window";
    };

    initContent = ''

      ghcl() {
        local repo="$1"
        [[ "$repo" != */* ]] && repo="MoDevIO/$repo"
        git clone "https://github.com/$repo.git"
      }

      # Kitty padding=0 for specific commands
      nvim() {
        kitty @ set-spacing padding=0
        command nvim "$@"
        kitty @ set-spacing padding=default
      }

      opencode() {
        kitty @ set-spacing padding=0
        command opencode "$@"
        kitty @ set-spacing padding=default
      }

      btop() {
        kitty @ set-spacing padding=0
        command btop "$@"
        kitty @ set-spacing padding=default
      }
    '';

  };
}
