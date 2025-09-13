{
  lib,
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # tooling
    # ../modules/home-manager/bittorrent.nix
    ../modules/home-manager/docker.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
    ../modules/home-manager/ghostty.nix
    ../modules/home-manager/kicad.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/starship/desktop.nix
    ../modules/home-manager/virtual-machine.nix
    ../modules/home-manager/vscode.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/zellij.nix
    ../modules/home-manager/zoxide/nitro.nix
    ../modules/home-manager/zsh.nix

    # spotify & spicetify
    ../modules/home-manager/spicetify.nix

    # theming
    # ../theming/hyprland/dracula/home.nix
    # ../theming/gnome/nitro/home.nix
    ../theming/plasma/dracula/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Packages
  home.packages =
    (with pkgs; [
      # with pkgs; [
      bat
      btop
      chezmoi
      distrobox
      dust
      fastfetch
      ffmpeg
      firefox # will use options later on
      freecad
      fzf
      gparted
      inkscape
      libreoffice
      ngrok
      obs-studio
      orca-slicer
      pdfarranger
      pdfmm
      platformio-core
      rclone
      tectonic-unwrapped
      thefuck
      tldr
      tree
      vlc
      yt-dlp
      zoxide
    ])
    ++ (with pkgs-unstable; [
      distrobox-tui
      logisim-evolution
      vesktop
    ]);

  # Config that needs to be symlinked
  # CAREFUL: it's read-only
  # home.file = {
  #   ".config/containers".source = ../config/containers;
  # };

  # some config I have isn't read-only, so this thing is needed
  home.activation = {
    linkNgrokYml = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/ngrok $HOME/.config/
    '';
  };

  home.activation = {
    linkRcloneConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/rclone/ $HOME/.config/
    '';
  };

  home.activation = {
    linkBtopConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/btop/ $HOME/.config/
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
