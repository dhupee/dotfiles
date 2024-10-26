{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs-unstable; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };
}
