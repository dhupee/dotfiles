{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  home.packages = with pkgs-unstable; [
    # kicad
    kicad-small
  ];

  home.activation = {
    linkKicadConfigs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/kicad $HOME/.config/
    '';
  };
}
