{
  description = "FHS Environment for uv and Python development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Create the FHS environment
        fhs = pkgs.buildFHSEnv {
          name = "uv-fhs-env";
          targetPkgs = pkgs:
            with pkgs; [
              # Essential packages for building Python wheels with C extensions
              uv
              git
              gnumake
              gcc
              pkg-config
              zlib
              stdenv.cc.cc.lib

              cudatoolkit

              # Add other system libraries your Python projects might need, e.g.,
              # openssl
              # sqlite
            ];

          # Automatically source or run setup upon entering the environment
          profile = ''
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.stdenv.cc.cc.lib}/lib
            alias venv-ldd-check='find .venv/ -type f -name "*.so" -print0 | xargs -0 -r ldd 2>/dev/null | grep "not found" | sort -u'

            # Optional: Tell uv to use a virtualenv named `.venv` in the local directory
            # export UV_PROJECT_ENVIRONMENT=$PWD/.venv
          '';

          # Run bash by default inside the FHS sandbox
          runScript = "bash";
        };
      in {
        devShells.default = fhs.env;
      }
    );
}
