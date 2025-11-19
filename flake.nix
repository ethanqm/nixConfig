{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stable-pkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stable-pkgs, stylix, ... }@inputs:
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
          stylix.nixosModules.stylix
          ./stylix.nix
        ];
      };
      mori = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system stable; };
        modules = [ 
          ./nixos/configuration.nix
          ./nixos/mori-hardware-configuration.nix
          stylix.nixosModules.stylix
          ./stylix.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.user = import ./home.nix;
          }
        ];
      };
    };
    # setup for non-nixos devices
    #homeConfigurations = {
    #  user = home-manager.lib.homeManagerConfiguration {
    #    inherit pkgs;
    #    modules = [ 
    #      stylix.nixosModules.stylix
    #      ./stylix.nix
    #      ./home.nix
    #    ];
    #  };
    #};
  };
}
