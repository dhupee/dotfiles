{pkgs, ...}: {
  # Steam & gamemode
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  };
  programs.gamemode.enable = true;

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
    ttyper
    # clinfo
    # ryzenadj
    # lact
  ];

  # Enable graphics drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  # AMD Ryzen specific configs
  hardware.cpu.amd = {
    ryzen-smu = {
      enable = false;
    };
  };
  programs.ryzen-monitor-ng.enable = false;

  # AMD GPU specific configs
  hardware = {
    amdgpu = {
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
      initrd.enable = true;
      opencl.enable = true;
      overdrive = {
        enable = false;
      };
    };
  };

  # Linux GPU Configuration And Monitoring Tool (LACT)
  # Enable lact in systemd to make it work
  # systemd = {
  #   packages = with pkgs; [lact];
  #   services.lactd.wantedBy = ["multi-user.target"];
  # };

  # Nvidia GPU specific configs
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true; # Lets you use `nvidia-offload %command%` in steam
  #     };
  #
  #     # run `nix shell nixpkgs#pciutils -c lspci | grep VGA`
  #     # to find the PCI Bus IDs
  #     intelBusId = "PCI:00:02:0";
  #     # amdgpuBusId = "PCI:0:0:0";
  #     nvidiaBusId = "PCI:01:00:0";
  #   };
  # };
}
