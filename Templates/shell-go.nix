{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Basic build inputs (add or remove as needed)
  buildInputs = with pkgs; [
    go_1_23
    air # for backend
  ];

  # # Environment variables (customize or remove as needed)
  shellHook = ''
    # export MY_ENV_VAR="my_value"    # Example: Define environment variables
    # Uncomment the following line if you want to run commands automatically in the shell:
    echo ""
    echo "Nix Shell is initialized"
  '';
}
