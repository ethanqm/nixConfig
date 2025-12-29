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
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, stable-pkgs, stylix, nix-on-droid, ... }@inputs:
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
        specialArgs = { inherit inputs system stable; };
        modules = [ 
          ./nixos/configuration.nix
          ./nixos/lapnix-hardware-configuration.nix
          stylix.nixosModules.stylix
          ./stylix.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.user = import ./home.nix;
          }
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

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs { system = "aarch64-linux"; };
      modules = [ ];
    };
    # setup for non-nixos devices
    # https://www.reddit.com/r/NixOS/comments/18eomkl/comment/kcrijan/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    # https://github.com/kaleocheng/nix-dots
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
