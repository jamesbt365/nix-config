{
  description = "mmm flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, nix-gaming, home-manager }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        snowland = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.pkgs = pkgs; }
            ./hosts/snowland/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./users/james/home.nix;
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
      homeConfigurations = {
        james = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/james";
          username = "james";
          configuration.imports = [ ./users/james/home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
