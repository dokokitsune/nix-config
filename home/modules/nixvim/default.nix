{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./plugins.nix
    ./lsp.nix
    ./completion.nix
    ./keymaps.nix
    ./which-key.nix
    
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
