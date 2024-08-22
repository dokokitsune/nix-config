{pkgs,  ...}: {
  home.packages  = with pkgs; [
    cmake
    gcc
    nodejs_22

    
  ];
}
