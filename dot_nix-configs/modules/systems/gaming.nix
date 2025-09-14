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
  ];

  # Enable graphics drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  # AMD specific configs, still not sure used or not
  hardware.amdgpu = {
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

  # Just in case if i have Nvidia Laptops
  # hardware.nvidia.modesetting.enable = true;
  #
  #   hardware.nvidia.prime = {
  #   offload = {
  #     enable = true;
  #     enableOffloadCmd = true; # Lets you use `nvidia-offload %command%` in steam
  #   };
  #
  #   # run `nix shell nixpkgs#pciutils -c lspci | grep VGA`
  #   # to find the PCI Bus IDs
  #   intelBusId = "PCI:00:02:0";
  #   # amdgpuBusId = "PCI:0:0:0";
  #   nvidiaBusId = "PCI:01:00:0";
  # };
}
