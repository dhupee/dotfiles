{pkgs, ...}: {
  boot.kernelParams = ["amd_pstate=passive"];
  boot.kernel.sysctl = {
    "scaling_governor" = "performance";

    "vm.dirty_background_ratio" = 3; # start flushing very early
    "vm.dirty_ratio" = 40; # still allow large cache
    "vm.dirty_writeback_centisecs" = 500; # flush every 5 sec
    "vm.dirty_expire_centisecs" = 500; # expire quickly
    "vm.swappiness" = 10; # how aggressively your system moves data out of RAM and into Swap
  };
  powerManagement.cpuFreqGovernor = "performance";

  # Add additional mount options
  fileSystems."/" = {
    options = [
      "noatime" # Do not update inode access times on this filesystem
    ];
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 20; # smaller = less CPU work
    algorithm = "lz4"; # fastest compression
    priority = 100; # use ZRAM before disk swap
  };

  # Enable graphics drivers
  # Already has Mesa in it
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa;
    package32 = pkgs.pkgsi686Linux.mesa;
  };

  # services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable Tux Clocker
  programs.tuxclocker = {
    enable = true;
    useUnfree = true;
    # enabledNVIDIADevices = [ 0 1 ];
  };

  # AMD Ryzen specific configs
  hardware.cpu = {
    x86.msr.enable = true;
    amd = {
      ryzen-smu = {
        enable = true;
      };
    };
  };
  programs.ryzen-monitor-ng.enable = false;

  # AMD GPU specific configs
  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive = {
        enable = true;
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
