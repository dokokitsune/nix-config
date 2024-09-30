{
  description = "main nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
     url = "github:nix-community/home-manager";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
     url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # if you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";

      inputs.nixpkgs.follows = "nixpkgs";
  };
    ags.url = "github:Aylur/ags";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
   zen-browser.url = "github:MarceColl/zen-browser-flake";



  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      
      systems = ["x86_64-linux"];
      imports = [./flake];
    } ;

}
            
          
