{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312Packages.virtualenv
  ];

  shellHook = ''
    # Create .venv directory if it doesn't exist
    if [ ! -d .venv ]; then
      python3 -m venv .venv
    fi

    # Activate the virtual environment
    source .venv/bin/activate

    # Install requirements if requirements.txt exists
    if [ -f requirements.txt ]; then
      pip install -r requirements.txt
    fi

    # Print message when the virtual environment is ready
    echo "Python virtual environment (.venv) is ready with requirements installed."
  '';
}
