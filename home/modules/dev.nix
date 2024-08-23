{pkgs,  ...}: {
  home.packages  = with pkgs; [
    python3
    cmake
    gcc
    nodejs_22

    
  ];
}
