{pkgs, ...}: {
  # ---- Kernel Parameters ----
  boot.kernelParams = [
    "amd_pstate=active" # Modern AMD P-state driver (required by PPD's EPP control).
    "pcie_aspm=off" # Disables PCIe ASPM to avoid NVMe latency spikes.
    "nvme_core.default_ps_max_latency_us=0" # Disables NVMe low-power states to prevent I/O stalls.
  ];

  # ---- Kernel Sysctl ----
  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 3; # Start background writeback early.
    "vm.dirty_ratio" = 40; # Max dirty pages before blocking writes.
    "vm.dirty_writeback_centisecs" = 1500; # Flush dirty pages every 15s.
    "vm.dirty_expire_centisecs" = 3000; # Dirty pages expire after 30s.
    "vm.swappiness" = 10; # Prefer RAM over swap.
  };

  # ---- Filesystem ----
  fileSystems."/" = {
    options = [
      "noatime" # Skip access-time updates on reads.
      "discard" # Real-time TRIM for SSD blocks.
      "commit=60" # Sync FS journal every 60s.
    ];
  };
  services.fstrim.enable = true; # Periodic TRIM as a safety net.

  # ---- Swap ----
  zramSwap = {
    enable = true;
    memoryPercent = 20; # Use 20% of RAM for compressed swap.
    algorithm = "lz4"; # Fast compression algorithm.
    priority = 100; # Higher priority than disk swap.
  };

  # ---- Graphics ----
  boot.initrd.kernelModules = ["amdgpu"]; # Load amdgpu early in initrd.
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa;
    package32 = pkgs.pkgsi686Linux.mesa;
  };
  # hardware.amdgpu.amdvlk = true; # Uncomment to use AMDVLK instead of RADV.

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi"; # VA-API driver for hardware video decode.
    VDPAU_DRIVER = "radeonsi"; # VDPAU driver for legacy video decode.
  };

  # ---- ROCm / OpenCL ----
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd # OpenCL ICD for ROCm.
  ];
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}" # Symlink ROCm to /opt/rocm.
  ];
  environment.variables.ROC_ENABLE_PRE_VEGA = "1"; # Enable ROCm on Polaris/Vega GPUs.

  # ---- Monitoring & Overclocking ----
  programs.tuxclocker = {
    enable = false;
    useUnfree = false;
  };
  hardware.cpu = {
    x86.msr.enable = true; # Enable MSR access for CPU monitoring.
    amd.ryzen-smu.enable = true; # Enable Ryzen SMU sensors.
  };
  programs.ryzen-monitor-ng.enable = false;
  hardware.amdgpu.overdrive.enable = true; # Allow GPU clock/voltage control.

  # ---- Power Management ----
  services.power-profiles-daemon.enable = true; # Dynamic CPU/GPU power profiles.
  services.tlp.enable = false; # Conflicts with PPD; keep disabled.

  # Switch PPD profile automatically on AC plug/unplug.
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
  '';

  # ---- PRIME (Dual GPU) ----
  # iGPU drives the desktop by default; run `DRI_PRIME=1 <cmd>` to use the dGPU.
}
