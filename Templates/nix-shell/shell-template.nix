# shell-template.nix
{pkgs ? import <nixpkgs> {}}:
# You can also specify multiple Nixpkgs channels by uncommenting these lines:
# let
#   nixpkgs_24_05 = import (fetchTarball {
#     url = "https://releases.nixos.org/nixos/24.05/nixexprs.tar.xz";
#     sha256 = "<replace-with-actual-sha256>";
#   }) {};
#   nixpkgs_23_05 = import (fetchTarball {
#     url = "https://releases.nixos.org/nixos/23.05/nixexprs.tar.xz";
#     sha256 = "<replace-with-actual-sha256>";
#   }) {};
# in
pkgs.mkShell {
  # Basic build inputs (add or remove as needed)
  buildInputs = with pkgs; [
    # Uncomment and add specific dependencies here:
    # go_1_20                   # Example: Go 1.20
    # nodejs-iron               # Example: Node.js Iron version
    # python39                 # Example: Python 3.9
    # cmake                    # Example: CMake build system
    # gcc                      # Example: GCC compiler
    # git                      # Example: Git version control
    # more-dependencies-here   # Add as needed
  ];

  # Environment variables (customize or remove as needed)
  shellHook = ''
    export MY_ENV_VAR="my_value"    # Example: Define environment variables
    # Uncomment the following line if you want to run commands automatically in the shell:
    # echo "Welcome to the development environment!"
  '';

  # Optional: Add or remove these extra packages that are common in development environments
  nativeBuildInputs = with pkgs; [
    # Example: Native dependencies needed for building software, e.g., autoconf or libtool
    # autoconf
    # libtool
  ];

  # Additional configuration (like setting up a different shell)
  # Uncomment if you want to set up a specific shell:
  # shell = pkgs.zsh;   # Example: Using Zsh instead of default Bash

  # Optional: Additional arguments to pass to other build tools
  # args = [ "--some-option" ];

  # Optional: Specify a specific package or Nixpkgs version to use for particular tools
  # fetchGo = nixpkgs_24_05.go_1_20;   # Example of fetching from another channel

  # Optional: Use overlays or custom Nix expressions
  # overlays = [
  #   (self: super: {
  #     myCustomPackage = super.callPackage ./my-custom-package.nix {};
  #   })
  # ];

  # Optional: Set up extra paths or binaries
  # PATH = "${pkgs.somePackage}/bin:${PATH}";
}
