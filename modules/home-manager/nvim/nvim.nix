{
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
  };

  imports = [
    ./options.nix
    ./keybinds.nix
    ./colorscheme.nix
    ./plugins
    ./lsp.nix
  ];
}
