{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        copilot-lua = prev.vimPlugins.copilot-lua.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "zbirenbaum";
            repo = "copilot.lua";
            rev = "v3.0.4";
            hash = "sha256-kDQOm7/N6T7wOw1JlkcxNMnQrDE4oTRyGCZkvT8HZQw=";
          };
        });
      };
    })
  ];
}
