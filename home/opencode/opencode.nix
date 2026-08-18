{ config, ... }:

{
  sops = {
    secrets."openrouter_api_key" = { };
    templates."openrouter_api_key" = {
      path = "${config.home.homeDirectory}/.local/share/opencode/auth.json";
      content = ''
        {
          "openrouter": {
            "type": "api",
            "key": "${config.sops.placeholder."openrouter_api_key"}"
          }
        }
      '';
    };
  };

  programs.opencode = {
    enable = true;
  };
}
