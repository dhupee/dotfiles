{pkgs, ...}: {
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = false;
    };
    package = pkgs.steam.override {
      # extraEnv = {
      #   MANGOHUD = true;
      #   OBS_VKCAPTURE = true;
      #   RADV_TEX_ANISO = 16;
      # };
      extraLibraries = pkgs: [pkgs.xorg.libxcb];
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };

  # Gamemode and Gamescope
  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = false;
      # capSysNice = true;
    };
  };

  # Add packages system level
  environment.systemPackages = with pkgs; [
    wine
    heroic
    lutris
    osu-lazer-bin
    protonup-qt
    (retroarch.withCores (cores:
      with cores; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw # PS1
        play # PS2
      ]))
    mangohud
    ttyper
    # ryzenadj
    # lact
  ];
}
