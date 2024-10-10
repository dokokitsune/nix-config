#Main Nix Config

{inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

    ];
  # Use the systemd-boot EFI boot loader.

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
  swapDevices = [ {device = "/swap/swapfile"; } ];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };


  nix = {
     gc = {
       automatic = true;
       dates = "weekly";
       options = "--delete-older-than 7d";
     };
     settings = {
       experimental-features = "nix-command flakes";
     };
  };

  virtualisation.docker.enable = true;

  services.upower.enable = true;
  nixpkgs.config.allowUnfree = true;
  

  networking.networkmanager = {
    enable = true;
  };
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.dbus.packages = with pkgs; [gnome-keyring];
  

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable the X11 windowing system.
   services.xserver.enable = true;
    programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
 programs.thunar = {
	enable = true;
	plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
		];
  };

 
 	 
users.users.wwood = {
	isNormalUser = true;
	home = "/home/wwood";
	extraGroups = [ "networkmanager" "wheel" "docker" ];
};
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
 services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

fonts.packages = with pkgs; [
  (nerdfonts.override {fonts  = ["CascadiaCode"];})
];



 services.displayManager.sddm = {
   enable = true;
   theme = "catppuccin-macchiato";
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
 }; 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
    gnome-keyring
    libsecret
    btrfs-progs
    mesa
    vulkan-tools
    hyprland
    hyprland-protocols
    mako
    hyprshot
    networkmanagerapplet
    waybar
    xdg-desktop-portal-hyprland	
    kitty
    fastfetch
    polkit_gnome
    wofi
    wget
    wireplumber
		ripgrep
    brightnessctl
 		tldr
    hyprpaper
    wl-clipboard
    wlogout
    upower
    waybar
    xwaylandvideobridge
    (catppuccin-sddm.override{
      flavor = "macchiato";
      font = "CaskaydiaCove Nerd Font";
      background = "${./backgrounds/cat-login.jpg}";
      loginBackground = false;
      fontSize = "9";
     })
];

  system.stateVersion = "23.11";

}

