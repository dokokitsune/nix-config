{pkgs, lib, inputs, ...}: {
  imports = [
    ./ags
    ./hyprland
    ./kitty
    ./nixvim
    ./git.nix
    ./dev.nix
    ./shell.nix
  ];

}

