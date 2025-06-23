{pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/dd5c2540983641bbaabdfc665931592d4c9989e8.tar.gz") {}}:
pkgs.mkShell {
  # Basic build inputs (add or remove as needed)
  buildInputs = with pkgs; [
    esptool
    clang-tools
  ];

  # # Environment variables (customize or remove as needed)
  shellHook = ''
    # export MY_ENV_VAR="my_value"    # Example: Define environment variables
    # Uncomment the following line if you want to run commands automatically in the shell:
    echo ""
    echo "Nix Shell is initialized"
  '';
}
