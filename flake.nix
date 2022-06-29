{
  description = "mmm flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-gaming go brrr
    nix-gaming.url = "github:fufexan/nix-gaming";
    };

  outputs = { self, nixpkgs, nix-gaming, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      overlays = (import ./overlays);
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
              home-manager.users.lily = import ./users/lily/home.nix;
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
      homeConfigurations = {
        lily = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/lily";
          username = "lily";
          configuration.imports = [ ./users/lily/home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
