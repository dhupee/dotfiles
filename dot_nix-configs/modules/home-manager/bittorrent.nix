{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nyaa
    stig
    transgui
    transmission_4-gtk
  ];

  home.activation = {
    linkNyaaConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/nyaa $HOME/.config/
    '';
  };
}
