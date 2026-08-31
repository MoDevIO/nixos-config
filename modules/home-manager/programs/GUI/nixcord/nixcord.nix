{
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;

    user = "mo";

    quickCss = builtins.readFile ./quick.css;
    config = {
      useQuickCss = true;
      themeLinks = [ ];

      plugins = { };
    };
  };
}
