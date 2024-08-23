{pkgs,  ...}: {
  home.packages  = with pkgs; [
    conda
    python3
    cmake
    gcc
    nodejs_22

    
  ];
}
