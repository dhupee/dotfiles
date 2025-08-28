{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  environment.sessionVariables = {
    # hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";

    # in case my cursors go missing
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    wofi
    kdePackages.dolphin
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # hardware = {
  #   nvidia.modesetting.enable = true;
  # };
}
