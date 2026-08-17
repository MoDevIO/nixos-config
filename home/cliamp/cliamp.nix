{ pkgs, ... }:

{
  home.packages = [
    pkgs.cliamp
  ];
  home.file.".config/cliamp/config.toml".text = ''
    [spotify]
    client_id = "83e1a2a15d9e42b9bfcd755cb686f7da"
  '';
}
