{pkgs, ...}: {
  # Enable Gnome as Desktop Environment
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];

  # I dont need any of this
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gedit # text editor
    ])
    # ++ (with pkgs.gnome; [
    ++ (with pkgs; [
      # cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
}
