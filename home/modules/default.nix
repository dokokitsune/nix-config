{pkgs, lib, inputs, ...}: {
  imports = [
    ./ags
    ./hyprland
    ./nixvim
    ./git.nix
    ./dev.nix
    ./shell.nix
  ];

}

