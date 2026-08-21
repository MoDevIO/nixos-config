{ pkgs, hostname, ... }:

{
  home.packages = [
    # Language servers
    pkgs.vscode-langservers-extracted
    pkgs.emmet-language-server
    pkgs.vtsls
    pkgs.lua-language-server
    pkgs.pyright
    pkgs.nixd
    pkgs.kdePackages.qtdeclarative

    # Formatters
    pkgs.prettier
    pkgs.nixfmt
    pkgs.luaformatter
  ];

  programs.nixvim = {
    lsp.servers = {
      html = {
        enable = true;
        config = {
          cmd = [
            "vscode-html-language-server"
            "--stdio"
          ];
          filetypes = [
            "html"
          ];
        };
      };

      emmet_language_server = {
        enable = true;
        config = {
          cmd = [
            "emmet-language-server"
            "--stdio"
          ];
          filetypes = [
            "html"
            "css"
            "scss"
          ];
        };
      };

      vtsls = {
        enable = true;
        config = {
          cmd = [
            "vtsls"
            "--stdio"
          ];
          filetypes = [
            "javascript"
            "typescript"
            "javascriptreact"
            "typescriptreact"
          ];
        };
      };

      nixd = {
        enable = true;
        config = {
          cmd = [
            "nixd"
            "--log=debug"
          ];
          filetypes = [
            "nix"
          ];

          settings = {
            nixd = {
              nixpkgs.expr = "import (builtins.getFlake \"git+file:///home/mo/Documents/Coding/nix-config\").inputs.nixpkgs { }";

              options = {
                nixos.expr =
                  "(builtins.getFlake \"git+file:///home/mo/Documents/Coding/nix-config\").nixosConfigurations."
                  + hostname
                  + ".options";

                home_manager.expr =
                  "(builtins.getFlake \"git+file:///home/mo/Documents/Coding/nix-config\").nixosConfigurations."
                  + hostname
                  + ".options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };

      lua_ls = {
        enable = true;
        config = {
          cmd = [ "lua-language-server" ];
          filetypes = [ "lua" ];

          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" ];
              };
            };
          };
        };
      };

      qmlls = {
        enable = true;
        config = {
          cmd = [
            "qmlls"
            "-E"
            "-I"
            "${pkgs.quickshell}/lib/qt-6/qml"
          ];
          filetypes = [ "qml" ];
        };
      };

      pyright = {
        enable = true;
        config = {
          cmd = [
            "pyright-langserver"
            "--stdio"
          ];
          filetypes = [ "python" ];
        };
      };
    };
    diagnostic.settings = {
      signs.text = {
        ERROR = "";
        WARN = "";
        INFO = "";
        HINT = "";
      };
    };
  };
}
