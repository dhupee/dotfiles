{pkgs, ...}: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    heroic
    lutris
    protonup-qt
    (retroarch.withCores (cores:
      with cores; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw # PS1
        pcsx2 # PS2
      ]))
  ];

  # services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  # hardware.nvidia.modesetting.enable = true;
  #
  #   hardware.nvidia.prime = {
  #   offload = {
  #     enable = true;
  #     enableOffloadCmd = true; # Lets you use `nvidia-offload %command%` in steam
  #   };
  #
  #   intelBusId = "PCI:00:02:0";
  #   # amdgpuBusId = "PCI:0:0:0";
  #   nvidiaBusId = "PCI:01:00:0";
  # };
}
