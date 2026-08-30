{ hostname, ... }:

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
      nors = "sudo nixos-rebuild switch --flake ~/Documents/Coding/nix-config#" + hostname;

      # nvim
      nvimnix = "cd ~/Documents/Coding/nix-config && nvim .";
    };
  };

}
