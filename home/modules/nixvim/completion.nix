{
  programs.nixvim = {
    plugins = {
      luasnip = {
        enable = true;
      };
      lspsaga = {
        enable = true;
        lightbulb.enable = false;
      };
      lspkind = {
        enable = true;
        preset = "codicons";
        cmp.enable = true;
      };
      lsp-lines.enable = true;
      lsp-status.enable = true;
      
      cmp_luasnip = {
        enable = true;
      };
      cmp-nvim-lsp = {
        enable = true;
      };
      cmp-path = {
        enable = true;
      };
      cmp-buffer = {
        enable = true;
      };
      cmp-nvim-lsp-signature-help = {
        enable = true;
      };
      
      cmp = {
        enable = true;
        settings = {
          snippit = {expand = "luasnip";};
          completion = {
            completeopt = "menu menuone preview noselect";
          };
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = " cmp.mapping.confirm({select = false})";
          };
          sources = [
            
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "buffer";}
            {name = "path";}
          ];
          

      };
      
        };
      

    };

  };
}
