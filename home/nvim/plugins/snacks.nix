{ pkgs, ... }:

{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      notifier = {
        enabled = true;
      };
      explorer = {
        enabled = true;
      };
      picker = {
        enabled = true;
        sources = {
          explorer = { };
        };
      };
      dashboard = {
        enabled = true;
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
      };
    };
  };

  home.packages = [
    pkgs.fd
  ];
}
