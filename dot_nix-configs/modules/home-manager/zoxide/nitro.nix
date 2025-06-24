{
  config,
  pkgs,
  lib,
  ...
}: {
  programs = {
    zsh = {
      initContent = lib.mkOrder 1000 ''
        export _ZO_DATA_DIR=$HOME/.local/share/chezmoi/mutable-configs/zoxide/nitro

        eval "$(zoxide init zsh)"
      '';
    };
  };
}
