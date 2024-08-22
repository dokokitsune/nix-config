{
  programs.nixvim = {
    colorschemes.catppuccin= {
      enable = true;
      settings.flavour = "macchiato";
    };
    opts = {
      updatetime = 100;
      clipboard = "unnamedplus";
      hidden = true;
      background = "dark";
      relativenumber = true;
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      showmode = false;
      mouse = "a";
      termguicolors = true;
      hlsearch = true;
    };
  };
  
}
