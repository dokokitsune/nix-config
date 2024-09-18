{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        trouble = true;
        current_line_blame = true;
      };
    };
  };
}
