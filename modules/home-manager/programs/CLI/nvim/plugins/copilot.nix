{
  programs.nixvim.plugins.copilot-lua = {
    enable = true;
    settings = {
      server.type = "binary";
      suggestion = {
        enabled = true;
        auto_trigger = true;

        keymap = {
          accept = "<M-f>";
          accept_word = "<M-g>";
          dismiss = "<M-c>";
        };
      };
    };
  };
}
