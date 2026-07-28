{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    # package = pkgs.vscode-fhs;
    package = pkgs.vscode.fhsWithPackages (
      ps:
        with ps; [
          # Tooling
          gnumake
          cmake

          # Compiler
          gcc-arm-embedded

          # Toolchain and Version Manager
          stm32cubemx
          platformio-core
          uv

          # debugger
          gdb
          openocd
          stlink-gui
        ]
    );
  };
}
