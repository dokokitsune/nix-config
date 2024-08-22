{config, pkgs, inputs, sops-nix, ... }:

{
  imports = [
    ./modules 
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/wwood/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      gitEmail = {};
      gitUser = {};
      gitCred = {};
    };
  };

  systemd.user.services.sops-nix = {
    serviceConfig.User = "wwood";
  };
  
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
 
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wwood";
  home.homeDirectory = "/home/wwood";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  programs.kitty = {
    enable = true;
    extraConfig = ''
    font_family CaskaydiaCove Nerd Font

    background_opacity 0.9
    background_blur 1
    shell fish

    # The basic colors
    foreground              #cad3f5
    background              #24273a
    selection_foreground    #24273a
    selection_background    #f4dbd6

    # Cursor colors
    cursor                  #f4dbd6
    cursor_text_color       #24273a

    # URL underline color when hovering with mouse
    url_color               #f4dbd6

    # Kitty window border colors
    active_border_color     #b7bdf8
    inactive_border_color   #6e738d
    bell_border_color       #eed49f

    # OS Window titlebar colors
    wayland_titlebar_color system
    macos_titlebar_color system

    # Tab bar colors
    active_tab_foreground   #181926
    active_tab_background   #c6a0f6
    inactive_tab_foreground #cad3f5
    inactive_tab_background #1e2030
    tab_bar_background      #181926

    # Colors for marks (marked text in the terminal)
    mark1_foreground #24273a
    mark1_background #b7bdf8
    mark2_foreground #24273a
    mark2_background #c6a0f6
    mark3_foreground #24273a
    mark3_background #7dc4e4

    # The 16 terminal colors

    # black
    color0 #494d64
    color8 #5b6078

    # red
    color1 #ed8796
    color9 #ed8796

    color10 #a6da95

    # yellow
    color3  #eed49f
    color11 #eed49f

    # blue
    color4  #8aadf4
    color12 #8aadf4

    # magenta
    color5  #f5bde6
    color13 #f5bde6

    # cyan
    color6  #8bd5ca
    color14 #8bd5ca

    # white
    color7  #b8c0e0
    color15 #a5adcb

     '';
   };


   
   


   gtk = {
     enable = true;
     theme = {
       name = "Orchis-Orange-Dark";
       package = pkgs.orchis-theme;

     };
     iconTheme = {
       name = "Tela-orange";
       package = pkgs.tela-icon-theme;
     };
   };
  

   home.packages = with pkgs; [
    firefox
		discord
    git
    sops
    zoom-us
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wofi/config".text = 
    ''
allow_images=true
no_actions=true
hide_scroll=true
width=34%
height=34%

'';

    ".config/wofi/style.css".text = ''
#window {
  border-radius: 14px;
  background-color: #0d1117;
}

#input {
  padding: 4px;
  border-radius: 14px 14px 0 0;
  font-size: 16px;
  background-color: #0d1117;
  border: none;
  color: #ecf2f8;
}

#input:focus {
  box-shadow: none;
}

#scroll {
  border-radius: 14px;
  background-color: #161b22;
  margin: 0 12px 12px;
}

#inner-box {
  border-radius: 14px;
  padding: 12px;
}

#entry {
  padding: 8px;
}

#entry:selected {
  border-radius: 8px;
  background-color: #21262d;
}

#entry image {
  margin-right: 8px;
}
    '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wwood/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
