{pkgs, lib, inputs, ...}: {
  imports = [
    ./hyprland
    ./kitty
    ./nixvim
    ./waybar
    ./git.nix
    ./dev.nix
    ./shell.nix
  ];

}

