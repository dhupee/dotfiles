{pkgs, ...}: {
  # ---- Kernel & Performance Tuning ----
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  # NOTE: Kernel packages of choice move to flake for now
  boot.kernelParams = [
    "amd_pstate=passive"
  ];
  boot.kernel.sysctl = {
    "scaling_governor" = "performance";
    "vm.dirty_background_ratio" = 3;
    "vm.dirty_ratio" = 40;
    "vm.dirty_writeback_centisecs" = 500;
    "vm.dirty_expire_centisecs" = 500;
    "vm.swappiness" = 10;
  };
  powerManagement.cpuFreqGovernor = "performance";

  # Filesystem mount options
  fileSystems."/" = {
    options = [
      "noatime"
      "discard"
      "commit=60"
    ];
  };

  # ZRAM (swap in RAM)
  zramSwap = {
    enable = true;
    memoryPercent = 20;
    algorithm = "lz4";
    priority = 100;
  };

  # Load amdgpu module early in initrd
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Modern graphics stack (Mesa OpenGL / Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa;
    package32 = pkgs.pkgsi686Linux.mesa;
  };

  # Vulkan: RADV is the default Mesa driver (best for most games)
  # To switch to AMDVLK (AMD’s official driver), uncomment the next line.
  # hardware.amdgpu.amdvlk = true;

  # Hardware video acceleration (VA-API)
  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  # ---- ROCm / OpenCL for compute (Blender, DaVinci Resolve, etc.) ----
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd # OpenCL ICD for ROCm
  ];

  # Symlink ROCm libraries to standard /opt/rocm
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
  ];

  # For older AMD cards (Polaris / Vega) you might need this:
  environment.variables.ROC_ENABLE_PRE_VEGA = "1";

  # ---- Monitoring & Overclocking ----
  programs.tuxclocker = {
    enable = true;
    useUnfree = true;
    # enabledNVIDIADevices = [ 0 1 ];  # not needed for AMD
  };

  # AMD SMU (for sensors / overdrive)
  hardware.cpu = {
    x86.msr.enable = true;
    amd.ryzen-smu.enable = true;
  };
  programs.ryzen-monitor-ng.enable = false; # use tuxclocker instead

  # AMD GPU overdrive (allows clock / voltage control)
  hardware.amdgpu.overdrive.enable = true;

  # ---- Optional: Lact (another GPU control tool) ----
  # systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  # environment.systemPackages = [ pkgs.lact ];

  # ---- PRIME (Dual GPU offload) ----
  # Your Vega 8 iGPU will handle the desktop by default.
  # To run an app on the discrete Radeon RX GPU, use `DRI_PRIME=1`:
  #   DRI_PRIME=1 steam
  #   DRI_PRIME=1 glxinfo | grep "OpenGL renderer"
  # No additional configuration is required for AMD+AMD PRIME.

  # ---- (Optional) Suspend fix for some AMD laptops ----
  # boot.kernelParams = [ "modprobe.blacklist=amdgpu" ];
}
