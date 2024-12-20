{
  description = "Dhupee's Nix configuration for NixOS and Android.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      # url = "github:nix-community/home-manager/master";
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-on-droid,
    home-manager,
    plasma-manager,
    spicetify-nix,
  }: let
    system = "x86_64-linux"; # Adjust this if you are using a different architecture

    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
      system = system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    # Nix-on-Droid configuration
    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {system = "aarch64-linux";};
        modules = [./droids/default.nix];
      };
    };

    # NixOS configuration
    nixosConfigurations = {
      nitro = lib.nixosSystem {
        inherit system;
        modules = [
          # directory of the configuration nix of this profile
          ./desktop/nitro/configuration.nix
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit self;
        };
      };
      virts = lib.nixosSystem {
        inherit system;
        modules = [./desktop/virts/configuration.nix];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };

    # Home Manager configuration
    homeConfigurations = {
      dhupee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # directory of my home configuration
          ./home/dhupee.nix

          # Plasma manager tooling to customize KDE plasma
          plasma-manager.homeManagerModules.plasma-manager

          spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable spicetify-nix;
        };
      };
    };
  };
}
