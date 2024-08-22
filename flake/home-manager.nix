{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  flake.homeConfigurations.wwood = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      config = {
        allowUnfree = true;
      };
    };
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [../home/home.nix];
  };
}
