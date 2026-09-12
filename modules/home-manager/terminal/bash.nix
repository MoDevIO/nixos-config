{
  config,
  pkgs,
  systemName,
  ...
}:

{
  sops.secrets.ha_token = { };

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
    initExtra = ''
      ha-toggle() {
        local entity=''${1:-light.mo}
        local token=$(cat ${config.sops.secrets.ha_token.path})

        ${pkgs.curl}/bin/curl -s -X POST \
          -H "Authorization: Bearer $token" \
          -H "Content-Type: application/json" \
          -d "{\"entity_id\": \"light.mo\"}" \
          http://homeassistant:8123/api/services/light/toggle
      }
    '';
  };

}
