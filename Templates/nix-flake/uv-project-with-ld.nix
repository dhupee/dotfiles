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

      # List the Python packages you want to get libraries from
      pythonPackagesToGrab = with pkgs.python312Packages; [
        torch-bin # or torch
        # tensorflow-bin
        # numpy
      ];

      # Helper: Collect all unique library derivations needed by a list of Python packages
      collectRuntimeLibs = pythonPkgs: let
        # Recursively gather all runtime dependencies that are system libraries
        # (i.e., not Python packages). We look at `runtimeDependencies` and `buildInputs`
        gather = pkg: let
          candidates = (pkg.runtimeDependencies or []) ++ (pkg.buildInputs or []);
        in
          builtins.filter (dep: dep.isLibrary or false) candidates;
      in
        pkgs.lib.unique (builtins.concatMap gather pythonPkgs);

      # Extra libraries automatically derived from the chosen Python packages
      autoLibs = collectRuntimeLibs pythonPackagesToGrab;

      # Combine your manual libs with the auto‑discovered ones
      allLibs = with pkgs;
        [
          stdenv.cc.cc
          zlib
          cudatoolkit
        ]
        ++ autoLibs;
    in {
      devShells.default = pkgs.mkShell {
        name = "dev-environment";

        # Using the combined list of libraries
        NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath allLibs;

        # Dynamic linker (unchanged)
        NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

        # Packages you need – now we also include the chosen Python packages themselves
        packages = with pkgs;
          [
            uv
            gcc
            gnumake
          ]
          ++ pythonPackagesToGrab;

        shellHook = ''
          export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
          alias venv-ldd-check='find .venv/ -type f -name "*.so" -print0 | xargs -0 -r ldd 2>/dev/null | grep "not found" | sort -u'

          if [ ! -d .venv ] && [ -f pyproject.toml ] && command -v uv > /dev/null; then
            echo "📝 Initializing uv virtual environment..."
            uv venv
          elif [ ! -f pyproject.toml ]; then
            echo "Currently not in a python project, skipping uv virtual environment initialization."
            echo "To initialize uv virtual environment, run 'uv venv' in a python project directory."
          fi

          if [ -d .venv ] && [ -f .venv/bin/activate ]; then
            echo "🔧 Activating virtual environment..."
            source .venv/bin/activate
          fi

          if [ -n "$NIX_LD" ]; then
            echo "⚡ nix-ld is enabled: $(basename $NIX_LD)"
          else
            echo "⚠️  nix-ld not configured"
          fi
        '';
      };
    });
}
