{
  description = "THE";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        micro-env = pkgs.buildFHSEnv {
          name = "kcci-stm-env";
          targetPkgs = pkgs:
            with pkgs; [
              stm32cubemx
              stm32loader # Currently just work for UART Programming
              gcc-arm-embedded
              compiledb
              openocd
              inetutils
              clang-tools
            ];

          # Environment profile
          profile = ''
            alias lsp-gen="compiledb make"
            alias run-debugger-server="openocd -f interface/stlink.cfg -f target/stm32f4x.cfg"
            alias connect-ocd="telnet localhost 4444"
          '';

          # Run bash by default inside the FHS sandbox
          runScript = "bash --init-file /etc/profile";
        };
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              pdfarranger
              pdfmm
            ];
            shellHook = ''
              echo 'Development Shell Initialized'
            '';
          };
          micro = micro-env.env;
        };
      }
    );
}
