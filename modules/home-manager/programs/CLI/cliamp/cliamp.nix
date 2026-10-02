{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.cliamp
  ];

  sops.secrets."navidrome/password" = { };

  sops.templates."cliamp-config.toml" = {
    path = "${config.home.homeDirectory}/.config/cliamp/config.toml";
    content = ''
      [spotify]
      enabled = true
      client_id = "83e1a2a15d9e42b9bfcd755cb686f7da"

      [navidrome]
        url = "https://music.tilt.mn"
        user = "mo"
        password = ${config.sops.placeholder."navidrome/password"}
    '';
  };
}
