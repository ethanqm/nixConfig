{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stable-pkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs, home-manager, stable-pkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    stable = import stable-pkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      lapnix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [ 
          ./nixos/configuration.nix
          ./nixos/lapnix-hardware-configuration.nix
        ];
      };
      mori = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system stable; };
        modules = [ 
          ./nixos/configuration.nix
          ./nixos/mori-hardware-configuration.nix
        ];
      };
    };
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
        ];
      };
    };
  };
}
