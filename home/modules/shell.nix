{pkgs, ...}: {
  home.packages = with pkgs; [
    
    grc
    fish
    starship
  ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        '';
      plugins = [
        {name = "grc"; src = pkgs.fishPlugins.grc.src;}
      ];
    };

    starship = {
      enable = true;
      settings = {

      };


    };
  };
}
