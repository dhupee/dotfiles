{pkgs, ...}: {
  # To be able to work on wayland, cursor thingy I guess
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
  };
}
