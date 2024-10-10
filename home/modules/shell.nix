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
        function ls
          command ls -ahl --color=tty $argv
        end

        function gita
          command git add . $argv
        end

        function gitc
          command git commit -m $argv
        end

        function gitp
          command git push $argv
        end

          
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
