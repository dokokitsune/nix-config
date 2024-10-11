{pkgs,  ...}: {
  home.packages  = with pkgs; [
    awscli2
    conda
    (python3.withPackages (ps: with ps; with python3Packages; [
      jupyter
      ipython

      # Uncomment the following lines to make them available in the shell.
      # pandas
      # numpy
      # matplotlib
    ]))    
    cmake

    gcc
    nodejs_22
    dockerfile-language-server-nodejs

     

    
  ];
}
