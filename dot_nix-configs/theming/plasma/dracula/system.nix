{
  pkgs,
  config,
  ...
}: {
  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true; # this one uses x11
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # this one uses wayland
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    kate
    konsole
    oxygen
  ];
}
