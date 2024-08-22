{
  programs.nixvim = {
    plugins = {
      autoclose.enable = true;
      comment.enable = true;
      lualine = {
        enable = true;
      };
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
      image.enable = true;
      indent-blankline.enable = true;
      neoscroll.enable = true;
      notify.enable = true;
      nix.enable = true;
      oil.enable = true;
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
        };
      };
      treesitter-textobjects.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
          "<leader>ff" = "find_files";
          "<leader>fb" = "buffers";
          "<leader>fh" = "find_tags";
        };
      };
      todo-comments.enable = true;
      ts-autotag.enable = true;
      wilder = {
        enable = true;
        modes = [ ":" "/" "?" ];
      };
    };
  };
}
