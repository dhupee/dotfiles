{
  description = "Development environment with nix-ld support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      # Libraries required by your third-party pre-compiled binary
      requiredLibs = with pkgs; [
        stdenv.cc.cc
        openssl
        zlib
      ];
    in {
      devShells.default = pkgs.mkShell {
        buildInputs =
          requiredLibs
          ++ (
            with pkgs; [uv]
          );

        shellHook = ''
          # Points the binary to the system's dynamic linker wrapper
          export NIX_LD = "${pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"}";

          # Map the required libraries to the NIX_LD path lookups
          export NIX_LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath requiredLibs}";
        '';
      };
    });
}
