{ pkgs, ... }:

{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action.__raw = ''
          function()
            require("conform").format({ bufnr = 0, lsp_fallback = true })
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = ''
          function()
            Snacks.explorer()
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>g";
        action.__raw = ''
          function()
            Snacks.terminal("lazygit -p " .. vim.fs.root(0, ".git"))
          end
        '';
      }
    ];

    autoCmd = [
      {
        event = "LspAttach";
        callback.__raw = ''
          function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          end
        '';
      }
    ];
  };
  home.packages = [
    pkgs.lazygit
  ];
}
