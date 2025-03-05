{pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python310
    python310Packages.pip
    python310Packages.virtualenv
  ]);
  runScript = ''
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

    # Enter the shell, this must be run at the end
    bash
  '';
})
.env
