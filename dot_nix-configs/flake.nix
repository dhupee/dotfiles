{
  description = "Dhupee's Nix configuration for NixOS, Home Manager, and Android.";

  inputs = {
    # Always keeps one channel older
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-older.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-droid.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Enables me to install flatpaks declaratively
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    # Using cachyos's kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # Home-Manager, NixOS for your User Config
    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Using Nix on Android
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs-droid";
      # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

      inputs.home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        # follows = "home-manager";

        inputs.nixpkgs.follows = "nixpkgs-droid";
        #   inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
      };
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
    nixpkgs-older,
    nixpkgs-droid,
    nixpkgs-unstable,
    nix-cachyos-kernel,
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

    pkgs-older = import nixpkgs-older {
      system = system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    #===================NIX-ON-DROID CONFIGURATIONS==================================
    nixOnDroidConfigurations = {
      default = let
        # Only this config uses ARM64
        pkgs-droid = import nixpkgs-droid {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };

        # Create the dummy derivation that references the input sources
        keepSource-droid = pkgs-droid.runCommand "keep-nixpkgs-droid-source" {} ''
          mkdir -p $out
          echo ${inputs.nixpkgs-droid} > $out/droid-source-path
        '';

        keepSource-unstable = pkgs-droid.runCommand "keep-nixpkgs-unstable-source" {} ''
          mkdir -p $out
          echo ${inputs.nixpkgs-unstable} > $out/unstable-source-path
        '';
      in
        nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = pkgs-droid;
          modules = [
            ./droids/default.nix
            {
              environment.packages = [keepSource-droid keepSource-unstable];
            }

            # Enable unstable packages to Droids
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
          (
            {pkgs, ...}: {
              # Use nixpkgs from your environment, nixpkgs.config will apply.
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
              boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

              # Binary cache for Cachy kernel
              nix.settings.substituters = ["https://attic.xuyh0120.win/lantian"];
              nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
            }
          )
        ];
        specialArgs = {
          inherit pkgs-unstable self inputs;
        };
      };

      # Bare OCI image configuration
      oci-bare = lib.nixosSystem {
        inherit system;
        modules = [
          ./image/oci/bare/configuration.nix
        ];
        specialArgs = {
          inherit pkgs-unstable inputs;
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
          ./image/iso/bare-x86/configuration.nix
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

    #======================= DOCKER IMAGES ===========================#

    packages.${system} = {
      docker-min = pkgs.dockerTools.buildImage {
        name = "docker-min";
        tag = "latest";
        copyToRoot = pkgs.buildEnv {
          name = "root";
          paths = with pkgs; [
            bashInteractive
            cmatrix
            coreutils
            curl
            git
            vim
          ];
          pathsToLink = ["/bin"];
        };
        config = {
          # exact same config to dockerfile
          # capital, not uppercase
          Cmd = ["/bin/bash"];
          Env = ["PATH=/bin"];
        };
      };

      docker-layered = pkgs.dockerTools.buildLayeredImage {
        name = "docker-layered";
        tag = "latest";
        contents = with pkgs; [
          bashInteractive
          coreutils
          curl
          git
          vim
        ];

        # Optional: maximum number of layers (default 32, max 128)
        maxLayers = 20;

        config = {
          Cmd = ["${pkgs.bashInteractive}/bin/bash"];
          Env = ["PATH=/bin"];
        };

        # NOT available: runAsRoot, fromImage, fakeRootCommands, etc.
      };
    };
  };
}
