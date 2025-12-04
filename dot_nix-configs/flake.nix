{
  description = "Dhupee's Nix configuration for NixOS, Home Manager, and Android.";

  inputs = {
    # Always keeps one channel older
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Enables me to install flatpaks declaratively
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    # Home-Manager, NixOS for your User Config
    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Using Nix on Android
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # NixOS on Windows Subsystem for Linux
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ricing KDE Plasma Declaratively
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Ricing Spotify Declaratively
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
          # Similar effect to adding .nix configuration file to modules
          # Ignore the LSP Warning, it's used....used!!
          (
            {config, ...}: {
              config._module.args.pkgs-unstable = import nixpkgs-unstable {
                system = "aarch64-linux";
                config.allowUnfree = true;
              };
            }
          )
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

          # Nix-Flatpak, managing flatpak declaratively
          nix-flatpak.nixosModules.nix-flatpak
        ];
        specialArgs = {
          inherit pkgs-unstable self inputs;
        };
      };

      # WSL, hardware agnostic
      wsl-work = lib.nixosSystem {
        inherit system;
        modules = [
          ./wsl/work.nix

          # WSL specific options
          nixos-wsl.nixosModules.wsl
        ];
        specialArgs = {
          inherit pkgs-unstable inputs;
        };
      };

      # Bare ISO Configurations
      # Used only to build custom ISO
      iso-bare = lib.nixosSystem {
        inherit system;
        modules = [
          ./iso/bare-x86/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
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

          # Custom options from other community flakes
          plasma-manager.homeModules.plasma-manager # Plasma manager tooling to customize KDE plasma
          spicetify-nix.homeManagerModules.default # Spicetify to customize spotify
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable spicetify-nix inputs;
        };
      };

      # Minimum, CLI-only, distro agnostic config
      min = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # directory of my home configuration
          ./home/min.nix
          {
            home = {
              username = "dhupee";
              homeDirectory = "/home/dhupee/.distrobox/dev-arch";
            };
          }
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable inputs;
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
