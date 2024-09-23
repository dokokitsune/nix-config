{pkgs, inputs, ... }:

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
    slack
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
