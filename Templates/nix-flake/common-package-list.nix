{
  description = "dhupee learning JSX Front End with Go Backend";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Common packages list
        package_list = with pkgs; [
          # general
          go-task

          # Backend
          go

          # Frontend
          nodejs_22
        ];
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = package_list;

          shellHook = ''
            # make it impure by default, I don't care
            export SHELL=$(which ${pkgs.zsh})
            echo 'Development Shell Initialized'
            exec zsh
          '';
        };

        # packages.default = pkgs.stdenv.mkDerivation {
        #   pname = "firmware";
        #   version = "0.1.0";
        #   src = ./.;
        #   sandbox = false;
        #   buildInputs = with pkgs; [
        #     platformio-core
        #     esptool
        #   ];
        #   buildPhase = "platformio run";
        #   installPhase = "mkdir -p $out && cp -r .pio/build $out/";
        # };
      }
    );
}
