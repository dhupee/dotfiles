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
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # general
            go-task

            # for IoT stuff
            platformio-core
            clang
            clang-tools
            esptool

            # for Http request test
            ngrok
            python312
            python312Packages.fastapi
          ];
          shellHook = "echo 'Development Shell Initialized'";
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "firmware";
          version = "0.1.0";
          src = ./.;
          sandbox = false;
          buildInputs = with pkgs; [
            platformio-core
            esptool
          ];
          buildPhase = "platformio run";
          installPhase = "mkdir -p $out && cp -r .pio/build $out/";
        };
      }
    );
}
