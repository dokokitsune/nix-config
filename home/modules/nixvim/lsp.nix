{
  programs.nixvim = {
    plugins.fidget.enable = true;
    plugins.trouble.enable = true;
    plugins.lsp-format.enable = true;
    plugins.lsp = {
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
      };
    };
  };
}
