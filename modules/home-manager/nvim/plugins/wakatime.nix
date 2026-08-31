{ config, ... }:

{
  sops.secrets."wakatime_api_key" = { };
  sops.templates."wakatime".path = "${config.home.homeDirectory}/.wakatime.cfg";
  sops.templates."wakatime".content = ''
    [settings]
    debug = false
    hidefilenames = false
    ignore =
        COMMIT_EDITMSG$
        PULLREQ_EDITMSG$
        MERGE_MSG$
        TAG_EDITMSG$
    api_key=${config.sops.placeholder.wakatime_api_key}
  '';

  programs.nixvim.plugins.wakatime = {
    enable = true;
  };
}
