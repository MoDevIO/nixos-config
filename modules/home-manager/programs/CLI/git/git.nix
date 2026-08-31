{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "MoDevIO";
      user.email = "momo.tiltis@gmail.com";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  sops.secrets."gh_auth_token" = { };
  sops.templates."gh-hosts".path = "${config.home.homeDirectory}/.config/gh/hosts.yml";
  sops.templates."gh-hosts".content = ''
    github.com:
        user: MoDevIO
        oauth_token: ${config.sops.placeholder."gh_auth_token"}
        git_protocol: ssh
  '';
}
