{
  programs.nixvim = {
    plugins = {
      fidget.enable = true;
      trouble.enable = true;
      lsp-format = {
        enable = true;
      };

        lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          nixd.enable = true;
          bashls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          yamlls.enable = true;
        };
      };
      none-ls.enable = true;
    };
  };


}
