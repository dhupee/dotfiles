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

          # Compiler and Interpreter
          gcc-arm-embedded
          python3Minimal

          # Toolchain and Version Manager
          stm32cubemx
          platformio-core
          uv

          # Debugger and Programmer
          gdb
          openocd
          stlink-gui
          stm32loader
        ]
    );
  };
}
