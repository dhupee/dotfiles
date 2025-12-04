{...}: {
  # Enable graphics drivers
  # Already has Mesa in it
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
