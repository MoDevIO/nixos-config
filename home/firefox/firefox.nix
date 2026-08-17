{ firefox-addons, ... }:

let
  vimiumCss = builtins.readFile ./vimium.css;
in
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";

    profiles.default = {
      extensions = {
        packages = with firefox-addons; [
          ublock-origin
          bitwarden
          vimium-c
          return-youtube-dislikes
        ];

        settings."vimium-c@gdh1995.cn".force = true;
        settings."vimium-c@gdh1995.cn".settings = {
          userDefinedCss = vimiumCss;
          keyMappings = ''
            map J nextTab
            map K previousTab
          '';
        };
      };

      settings = {
        "extensions.autoDisableScopes" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.startup.page" = 3; # Reopen previous session
        "browser.translations.neverTranslateLanguages" = "en,de";
        "sidebar.verticalTabs" = true;

        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        "browser.newtabpage.pinned" = [
          {
            label = " ";
            url = "about:blank?1";
          }
          {
            label = " ";
            url = "about:blank?2";
          }
          {
            label = "G-Mail";
            url = "https://mail.google.com";
          }
          {
            label = "GitHub";
            url = "https://github.com";
          }
          {
            label = "Youtube";
            url = "https://youtube.com";
          }
          {
            label = "Reddit";
            url = "https://reddit.com";
          }
          {
            label = " ";
            url = "about:blank?7";
          }
          {
            label = " ";
            url = "about:blank?8";
          }
        ];
      };
    };
  };
}
