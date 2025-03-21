{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false; # make sure it uses the zsh-autocomplete instead
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      initExtra = ''

        source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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
      oh-my-zsh = {
        enable = true;
        plugins = [
          "thefuck"
          "copypath"
          "docker"
          "podman"
          "qrcode"
          "nvm"
          "node"
          "npm"
          "pyenv"
          "python"
          "golang"
          "zoxide"
        ];
      };
    };
  };
}
