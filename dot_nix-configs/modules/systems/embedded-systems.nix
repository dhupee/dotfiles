{pkgs, ...}: let
  # Custom Udev file for enabling programming FPGA in Xilinx Vivado
  custom-vivado-rules =
    pkgs.writeTextFile
    {
      name = "10-xilinx-vivado.rules";
      destination = "/etc/udev/rules.d/10-xilinx-vivado.rules";
      text = ''
        # xilinx-ftdi-usb.rules
        ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Xilinx", MODE:="666"

        # xilinx-digilent-usb.rules
        ATTR{idVendor}=="1443", MODE:="666"
        ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Digilent", MODE:="666"

        # xilinx-pcusb.rules
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
      '';
    };
in {
  environment.systemPackages = with pkgs; [
    # --- Tooling ---
    apio
    # logisim-evolution
    platformio-core
    # pulseview
    sigrok-firmware-fx2lafw
    # stm32cubemx

    # --- Debugger ---
    compiledb
    # seer
    # stlink-gui
    tio

    # --- Utils ---
    usbutils
  ];

  # Udev for embedded works
  services.udev = {
    packages =
      (with pkgs; [
        apio-udev-rules
        platformio-core.udev
        stlink
      ])
      ++ [
        # Check the let-in above
        custom-vivado-rules
      ];
  };

  # adding /bin/bash, needed by platformio
  system.activationScripts.binbash = ''
    mkdir -p /bin
    ln -sfn ${pkgs.bash}/bin/bash /bin/bash
  '';
}
