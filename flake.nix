{
  description = "A very basic NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: {
    nixosConfigurations = {
      hentai = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/hentai/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
