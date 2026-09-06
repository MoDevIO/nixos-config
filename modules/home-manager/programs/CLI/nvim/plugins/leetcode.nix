{
  programs.nixvim.plugins.leetcode = {
    enable = true;
    settings = {
      storage = {
        home = "~/.local/share/nvim/leetcode";
        cache = "~/.cache/nvim/leetcode";
      };
    };
  };

  home.file.".local/share/nvim/leetcode/.keep".text = "";
  home.file.".cache/nvim/leetcode/.keep".text = "";
}
