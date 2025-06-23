{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        # Sourcing aliases
          if [ -d ~/.aliases/ ]; then
              # Loop through all .sh files in the aliases directory and source them
              for file in ~/.aliases/*.sh; do
                  if [ -f "$file" ]; then
                      source "$file"
                  fi
              done
          else
              echo "Aliases directory not found"
          fi

          eval "$(thefuck --alias)"
      '';
    };
  };
}
