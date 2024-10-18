{
  description = "Dhupee's Nix configuration for NixOS and Android.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-on-droid, home-manager }:
    let
      system = "x86_64-linux"; # Adjust this if you are using a different architecture
      pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {

    # Nix-on-Droid configuration
    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./droids/default.nix ];
        # extraSpecialArgs = {
        #   pkgs-unstable = import nixpkgs-unstable { system = "aarch64-linux"; };
        # };
      };
    };

    # NixOS configuration
    nixosConfigurations = {
      nitro = lib.nixosSystem {
        inherit system;
        modules = [ ./desktop/nitro/configuration.nix ];
        # extraSpecialArgs = {
        #   inherit pkgs-unstable;
        # };
      };
      virts = lib.nixosSystem {
        inherit system;
        modules = [ ./desktop/virts/configuration.nix ];
        # extraSpecialArgs = {
        #   inherit pkgs-unstable;
        #   };
      };
    };

    # Home Manager configuration
    homeConfigurations = {
      dhupee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/dhupee.nix ];
        # extraSpecialArgs = {
        #   inherit pkgs-unstable;
        # };
      };
    };
  };
}

