{inputs, ...}: {
  flake.nixosConfigurations.wwood =  inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ../nixos/configuration.nix
      inputs.home-manager.nixosModules.home-manager

      {
        home-manager = {
          backupFileExtension = "backup";
          useGlobalPkgs = true;
          useUserPackages = true;
          users.wwood.imports = [../home/home.nix];
          extraSpecialArgs.inputs = inputs;
                    
        };
      }
    ];
  };
  
}
