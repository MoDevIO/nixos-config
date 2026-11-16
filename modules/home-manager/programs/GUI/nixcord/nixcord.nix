{ username, ... }:

{
  programs.nixcord = {
    enable = true;
    discord.enable = true;
    discord.vencord.enable = true;
    # vesktop.enable = true;

    user = username;

    quickCss = builtins.readFile ./quick.css;
    config = {
      useQuickCss = true;
      themeLinks = [ ];

      plugins = { };
    };
  };
}
