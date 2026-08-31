{ username, ... }:

{
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;

    user = username;

    quickCss = builtins.readFile ./quick.css;
    config = {
      useQuickCss = true;
      themeLinks = [ ];

      plugins = { };
    };
  };
}
