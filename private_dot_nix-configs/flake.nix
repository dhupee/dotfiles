{
  description = "Dhupee's Nix configuration for NixOS and Android.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-old";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
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
    nixos-wsl,
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
          ./linux/nitro/configuration.nix
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit self;
        };
      };
      wsl-work = lib.nixosSystem {
        inherit system;
        modules = [
          ./wsl/work/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
      virts = lib.nixosSystem {
        inherit system;
        modules = [./linux/virts/configuration.nix];
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

          plasma-manager.homeManagerModules.plasma-manager # Plasma manager tooling to customize KDE plasma
          spicetify-nix.homeManagerModules.default # Spictify to customize spotify
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable spicetify-nix;
        };
      };

      work = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # directory of my home configuration
          ./home/work.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
      };
    };
  };
}
