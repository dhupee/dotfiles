{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [kicad];

  home.activation = {
    linkKicadConfigs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/kicad $HOME/.config/
    '';
  };
}
