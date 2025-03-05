{
  description = "THE";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
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
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.platformio
            pkgs.clang-tools
            pkgs.esptool
            pkgs.go-task
          ];
          shellHook = "echo 'Development Shell Initialized'";
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "firmware";
          version = "0.1.0";
          src = ./.;
          sandbox = false;
          buildInputs = [
            pkgs.platformio
            pkgs.esptool
          ];
          buildPhase = "platformio run";
          installPhase = "mkdir -p $out && cp -r .pio/build $out/";
        };
      }
    );
}
