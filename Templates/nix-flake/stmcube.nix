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

        micro-essentials = with pkgs; [
          # Compiler and Loader
          stm32loader # Currently just work for UART Programming
          gcc-arm-embedded
          cmake
          clang-tools

          # Debugger and other utils
          compiledb
          openocd
          gdbgui
        ];

        env-profile = ''
          alias lsp-gen="compiledb make"
          alias run-debugger-server="openocd -f interface/stlink.cfg -f target/stm32f4x.cfg"
          alias connect-ocd="telnet localhost 4444"
        '';

        micro-env = pkgs.buildFHSEnv {
          name = "kcci-stm-env";
          targetPkgs = pkgs: micro-essentials ++ (with pkgs; [stm32cubemx]);

          # Environment profile
          profile = env-profile;

          # Run bash by default inside the FHS sandbox
          runScript = "bash --init-file /etc/profile";
        };

        micro-min-env = pkgs.buildFHSEnv {
          name = "kcci-stm-min-env";
          targetPkgs = pkgs: micro-essentials;

          # Environment profile
          profile = env-profile;

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

          micro-min = micro-min-env.env;
        };
      }
    );
}
