{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-anthy
        fcitx5-gtk
        fcitx5-configtool
      ];
      waylandFrontend = true;
      settings.inputMethod = {
        "Groups/0" = {
          "Name" = "Default";
          "Default Layout" = "us";
          "DefaultIM" = "mozc";
        };
        "Groups/0/Items/0" = {
          "Name" = "keyboard-us";
          "Layout" = null;
        };
        "Groups/0/Items/1" = {
          "Name" = "mozc";
          "Layout" = null;
        };
        "GroupOrder" = {
          "0" = "Default";
        };
      };
    };
  };
}
