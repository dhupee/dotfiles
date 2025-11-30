{
  description = "Go dev environment with air and go install support";

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
      pkgs = import nixpkgs {inherit system;};

      go-air = pkgs.buildGoModule {
        pname = "air";
        version = "1.48.0"; # or latest tag

        src = pkgs.fetchFromGitHub {
          owner = "cosmtrek";
          repo = "air";
          rev = "v1.48.0";
          sha256 = "sha256-04h3S3RRz7ib1N+pSpH8nA6TI9bQQ5L6Rg2rNdTCHfQ=";
        };

        vendorSha256 = "sha256-5j2GZktN1VBRqaTrb1jN2W6JxdSk2u3kSIkImC9hx8Q=";
      };
    in {
      devShells = {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.go
            go-air
          ];

          shellHook = ''
            export GOPATH=$PWD/.gopath
            export GOBIN=$GOPATH/bin
            export PATH=$GOBIN:$PATH
            mkdir -p $GOBIN

            echo "GOPATH set to $GOPATH"
            echo "Go Projects Environment Initialized"
          '';
        };
      };
    });
}
