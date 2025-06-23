{
  config,
  pkgs,
  ...
}: {
  programs = {
    bash = {
      initExtra = ''
        export _ZO_DATA_DIR=$HOME/.local/share/chezmoi/mutable-configs/zoxide/droid

        eval "$(zoxide init bash)"
      '';
    };
  };
}
