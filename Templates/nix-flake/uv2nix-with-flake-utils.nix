{
  description = "dhupee testing uv2nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    pyproject-nix,
    uv2nix,
    pyproject-build-systems,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Load workspace and create overlays
        workspace = uv2nix.lib.workspace.loadWorkspace {
          # always point the root towards your UV project root
          workspaceRoot = ./.;
        };
        overlay = workspace.mkPyprojectOverlay {sourcePreference = "wheel";};
        editableOverlay = workspace.mkEditablePyprojectOverlay {root = "$REPO_ROOT";};

        # Create Python package set
        pythonSet =
          (pkgs.callPackage pyproject-nix.build.packages {
            python = pkgs.python312;
          }).overrideScope (
            pkgs.lib.composeManyExtensions [
              pyproject-build-systems.overlays.wheel
              overlay
            ]
          );

        # Create editable Python set for dev shell
        editablePythonSet = pythonSet.overrideScope editableOverlay;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            (editablePythonSet.mkVirtualEnv "hello-world-dev-env" workspace.deps.all)
            pkgs.uv
          ];
          env = {
            UV_NO_SYNC = "1";
            UV_PYTHON = editablePythonSet.python.interpreter;
            UV_PYTHON_DOWNLOADS = "never";
          };
          shellHook = ''
            unset PYTHONPATH
            export REPO_ROOT=$(git rev-parse --show-toplevel)
            export SHELL=$(which ${pkgs.zsh})
            echo "Development Shell Initialized"
            exec zsh
          '';
        };

        packages.default = pythonSet.mkVirtualEnv "hello-world-env" workspace.deps.default;
      }
    );
}
