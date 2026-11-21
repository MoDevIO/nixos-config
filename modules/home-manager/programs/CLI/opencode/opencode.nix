{ config, ... }:

{
  sops = {
    secrets."openrouter_api_key" = { };
    secrets."opencode_api_key" = { };
    secrets."academiccloud_api_key" = { };

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
          },
          "academiccloud": {
            "type": "api",
            "key": "${config.sops.placeholder."academiccloud_api_key"}"
          }
        }
      '';
    };
  };

  programs.opencode = {
    enable = true;
    settings = {
      model = "academiccloud/deepseek-v4.1-flash-1017";
      "session.tps" = true;
      provider.academiccloud = {
        npm = "@ai-sdk/openai-compatible";
        name = "AcademicCloud";
        options = {
          baseURL = "https://chat-ai.academiccloud.de/v1";
          apiKey = "{file:${config.sops.secrets."academiccloud_api_key".path}}";
        };
        models."deepseek-v4.1-flash-1017" = {
          name = "DeepSeek V4.1 Flash";
        };
      };
    };
  };
}
