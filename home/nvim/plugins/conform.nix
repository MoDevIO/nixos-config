{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        html = [ "prettier" ];
        css = [ "prettier" ];
        scss = [ "prettier" ];
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        lua = [ "lua-format" ];
        nix = [ "nixfmt" ];
        python = [ "black" ];
      };

      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };
    };
  };
}
