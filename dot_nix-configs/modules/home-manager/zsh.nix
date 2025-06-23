{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false; # make sure it uses the zsh-autocomplete instead
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      initContent = lib.mkOrder 1200 ''

        source '${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh'

         # Sourcing aliases
         if [ -d ~/.aliases/ ]; then
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
          "bun"
          "copypath"
          "docker"
          "docker-compose"
          "golang"
          "macos"
          "node"
          "npm"
          "podman"
          "python"
          "qrcode"
          "ssh"
          "ssh-agent"
          "terraform"
          "thefuck"
          "zoxide"
        ];
      };
    };
  };
}
