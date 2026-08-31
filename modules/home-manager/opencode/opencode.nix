{ config, ... }:

{
  sops = {
    secrets."openrouter_api_key" = { };
    secrets."opencode_api_key" = { };
    templates."opencode-auth" = {
      path = "${config.home.homeDirectory}/.local/share/opencode/auth.json";
      content = ''
        {
          "openrouter": {
            "type": "api",
            "key": "${config.sops.placeholder."openrouter_api_key"}"
          },
          "opencode-go": {
            "type": "api",
            "key": "${config.sops.placeholder."opencode_api_key"}"
          }
        }
      '';
    };
  };

  programs.opencode = {
    enable = true;
  };
}
