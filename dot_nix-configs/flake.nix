{
  description = "Dhupee's Nix configuration for NixOS, Home Manager, and Android.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-25.05";
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
    nixpkgs-old,
    nixpkgs-unstable,
    nix-on-droid,
    home-manager,
    plasma-manager,
    spicetify-nix,
    nixos-wsl,
    nix-flatpak,
  } @ inputs: let
    system = "x86_64-linux"; # default systems for most of the machines

    # Stable fixed-release packages, kinda like Ubuntu
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };

    # Unstable packages, Arch like
    pkgs-unstable = import nixpkgs-unstable {
      system = system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    #===================NIX-ON-DROID CONFIGURATIONS==================================
    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        # Only this config uses ARM64
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };

        modules = [
          ./droids/default.nix

          # Enable unstable packages to Droids
          ({config, ...}: {
            config._module.args.pkgs-unstable = import nixpkgs-unstable {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
          })
        ];
      };
    };

    #============================NIXOS CONFIGURATIONS==================================
    nixosConfigurations = {
      # My Laptop
      nitro = lib.nixosSystem {
        inherit system;
        modules = [
          # directory of the configuration nix of this profile
          ./linux/nitro/configuration.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
        specialArgs = {
          inherit pkgs-unstable nix-flatpak self inputs;
        };
      };

      # WSL, hardware agnostic
      wsl-work = lib.nixosSystem {
        inherit system;
        modules = [
          ./wsl/work.nix
          nixos-wsl.nixosModules.wsl
        ];
        specialArgs = {
          inherit pkgs-unstable inputs;
        };
      };

      # Virtual Machine
      virts = lib.nixosSystem {
        inherit system;
        modules = [./linux/virts/configuration.nix];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };

    #==============================HOME-MANAGER CONFIGURATIONS===============================
    homeConfigurations = {
      # My personal shit
      dhupee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # directory of my home configuration
          ./home/dhupee.nix

          plasma-manager.homeModules.plasma-manager # Plasma manager tooling to customize KDE plasma
          spicetify-nix.homeManagerModules.default # Spictify to customize spotify
          # nix-flatpak.homeManagerModules.nix-flatpak # Flatpak
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable spicetify-nix inputs;
        };
      };

      # WSL
      wsl-work = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # directory of my home configuration
          ./home/wsl-work.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable inputs;
        };
      };
    };
  };
}
