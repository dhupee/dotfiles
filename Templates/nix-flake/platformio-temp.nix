{
  description = "THE";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
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
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            platformio-core
            clang
            clang-tools
            esptool
            python3Full
          ];
          shellHook = ''
            # make it impure by default, I don't care
            export SHELL=$(which ${pkgs.zsh})
            echo 'Development Shell Initialized'
            exec zsh
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "Tamu-v2";
          version = "0.1.0";
          src = ./.;
          sandbox = false;
          buildInputs = with pkgs; [
            platformio-core
            esptool
          ];
          buildPhase = "pio run";
          installPhase = "mkdir -p $out && cp -r .pio/build $out/";
        };
      }
    );
}
