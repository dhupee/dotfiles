{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      initExtra = ''
        export _ZO_DATA_DIR=$HOME/.local/share/chezmoi/mutable-configs/zoxide/nitro

        eval "$(zoxide init zsh)"
      '';
    };
  };
}
