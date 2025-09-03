{
  description = "A versatile flake template for build, run, and develop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
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
        # ========== PACKAGES (for `nix build`) ==========
        packages = {
          # Default package: build with `nix build` or `nix build .#default`
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "my-app";
            version = "0.1.0";
            src = ./.;
            cargoLock.lockFile = ./Cargo.lock;
            # Build dependencies (if any)
            nativeBuildInputs = with pkgs; [pkg-config];
            # Runtime dependencies (if any)
            buildInputs = with pkgs; [openssl];
          };

          # Add other packages here, e.g.:
          # my-script = pkgs.writeShellScriptBin "hello" ''echo "Hello!"'';
        };

        # ========== APPS (for `nix run`) ==========
        apps = {
          # Default app: run with `nix run` or `nix run .#default`
          default = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/my-app";
          };

          # Add other apps here, e.g.:
          # hello = {
          #   type = "app";
          #   program = "${self.packages.${system}.my-script}/bin/hello";
          # };
        };

        # ========== DEVELOPMENT SHELL (for `nix develop`) ==========
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              # Development tools
              rustc
              cargo
              pkg-config
              openssl
            ];
            # Environment variables
            RUST_BACKTRACE = "1";
            # Script run on shell startup
            shellHook = ''
              echo "Welcome to the dev shell! 🚀"
            '';
          };
        };

        # ========== FORMatter (optional) ==========
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
