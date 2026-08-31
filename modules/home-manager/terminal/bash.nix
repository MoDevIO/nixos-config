{ systemName, ... }:

{
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
      nors = "nh os switch ~/nixos-config#" + systemName;

      # nvim
      ssh = "TERM=xterm-256color ssh";
      nvimnix = "cd ~/nixos-config && nvim .";

      # Other
      ndd = "nautilus . & disown; kitty @ close-window";
    };
  };

}
