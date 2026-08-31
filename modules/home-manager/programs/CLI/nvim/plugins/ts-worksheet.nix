{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "tsw";
      src = pkgs.fetchFromGitHub {
        owner = "typed-rocks";
        repo = "ts-worksheet-neovim";
        rev = "main";
        hash = "sha256-PZY8HNnfFx7dtzxlTqGhVfQc2h0jfGb1fCcdLMhl6xU=";
      };
    })
  ];
}
