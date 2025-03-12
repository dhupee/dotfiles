{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    prusa-slicer
  ];

  # it's config are often mutable, so we need to make a symlink
  home.activation = {
    linkPrusaSlicerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/PrusaSlicer $HOME/.config/
    '';
  };
}
