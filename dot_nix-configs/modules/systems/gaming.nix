{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.sessionVariables = {
    OSU_SDL3 = "0";
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    package = pkgs.steam.override {
      # extraEnv = {
      #   MANGOHUD = true;
      #   OBS_VKCAPTURE = true;
      #   RADV_TEX_ANISO = 16;
      # };
      extraLibraries = pkgs: [pkgs.libxcb];
      extraPkgs = pkgs:
        with pkgs; [
          libxcursor
          libxi
          libxinerama
          libxscrnsaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils

          # NOTE: use this launch option `gamescope -W 1920 -H 1080 -e -- gamemoderun mangohud %command%`
          # switch to X11 if you really need gamescope
          steam-run
          mangohud
          gamemode
        ];
    };
  };

  # Gamemode and Gamescope
  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  # Add packages system level
  environment.systemPackages =
    (with pkgs; [
      steam-run
      gamescope
      wine
      heroic
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
    ])
    ++ (with pkgs-unstable; [
      osu-lazer
    ]);
}
