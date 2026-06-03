{pkgs, ...}: {
  # ---- Kernel & Performance Tuning ----
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  # NOTE: Kernel packages of choice move to flake for now
  boot.kernelParams = [
    "amd_pstate=passive" # AMD CPU freq. scaling driver (passive mode)
    "pcie_aspm=off" # Disable PCIe ASPM (reduces NVMe latency)
    "nvme_core.default_ps_max_latency_us=0" # Disable NVMe low-power states
  ];
  boot.kernel.sysctl = {
    "scaling_governor" = "performance"; # Force CPU to stay at high freq
    "vm.dirty_background_ratio" = 3; # Start background writeback early
    "vm.dirty_ratio" = 40; # Max dirty pages before blocking writes
    "vm.dirty_writeback_centisecs" = 500; # Flush dirty pages every 5 secs
    "vm.dirty_expire_centisecs" = 500; # Dirty pages expire after 5 secs
    "vm.swappiness" = 10; # Avoid swapping to disk
  };
  powerManagement.cpuFreqGovernor = "performance";

  # Forces the NVMe device to use BFQ
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="bfq"
  '';

  # Filesystem mount options
  fileSystems."/" = {
    options = [
      "noatime" # Don't update access time on reads
      "discard" # Real-time TRIM for SSD blocks
      "commit=60" # Sync FS journal every 60 secs
    ];
  };

  # Enable FSTrim (periodic TRIM for SSD)
  services.fstrim.enable = true;

  # ZRAM (swap in RAM)
  zramSwap = {
    enable = true;
    memoryPercent = 20; # Use 20% of RAM for compressed swap
    algorithm = "lz4"; # Fast compression algorithm
    priority = 100; # High priority, use ZRAM first
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
    enable = false; # Disabled, but available
    useUnfree = false;
    # enabledNVIDIADevices = [ 0 1 ];  # not needed for AMD
  };

  # AMD SMU (for sensors / overdrive)
  hardware.cpu = {
    x86.msr.enable = true; # Enable MSR (for monitoring)
    amd.ryzen-smu.enable = true; # Enable Ryzen SMU (sensors)
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
