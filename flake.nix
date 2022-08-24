{
  description = "System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, nix-gaming, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      #overlays = (import ./overlays);

      mkSystem = nixpkgs: name: arch: enableGUI:
        nixpkgs.lib.nixosSystem {
          system = arch;
          modules = [
            #  { nixpkgs.overlays = overlays; }
            (./hosts + "/${name}")
          ];
          specialArgs = {
            inherit inputs enableGUI;
            modules = import ./modules { lib = nixpkgs.lib; };
          };
        };

    in {
      nixosConfigurations."snowland" =
        mkSystem nixpkgs "snowland" "x86_64-linux" true;
      packages."x86_64-linux" = let
        pkgs = import nixpkgs {
          #  inherit overlays;
          system = "x64_64-linux";
        };
      in { inherit (pkgs.me) linux-lava; };
    };
}
