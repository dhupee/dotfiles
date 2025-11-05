{
  description = "Dart Project Flakes using FVM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
          config = {
            android_sdk.accept_license = true; # can delete if you dont use android SDK
            allowUnfree = true;
          };
        };

        # Manually tuned SDK
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = ["34.0.0" "28.0.3"];
          platformVersions = ["34" "28"];
          abiVersions = ["armeabi-v7a" "arm64-v8a"];
        };
        androidSdk_1 = androidComposition.androidsdk;

        # prepackaged SDK
        androidSdk_2 = pkgs.androidenv.androidPkgs.androidsdk;

        # Path for chromium
        chrome_path = "${pkgs.chromium}/bin/chromium";

        # FVM Paths
        paths = ''
          export PATH=$PATH:~/.pub-cache/bin
          export PATH="$HOME/fvm/default/bin:$PATH"
          export PATH="$HOME/.fvm_flutter/bin:$PATH"
        '';

        # Shellhook, use ZSH by default, cause it to run impurely
        impure_hook = ''
          export SHELL=$(which ${pkgs.zsh})
          echo 'Development Shell Initialized'
          exec zsh
        '';
      in {
        devShells = {
          # Web Only
          default = pkgs.mkShell {
            CHROME_EXECUTABLE = chrome_path;
            buildInputs = with pkgs; [
              fvm
              chromium
            ];
            shellHook = paths + impure_hook;
          };

          # use fine-tuned sdk
          android1 = pkgs.mkShell {
            ANDROID_SDK_ROOT = "${androidSdk_1}/libexec/android-sdk";
            CHROME_EXECUTABLE = chrome_path;
            buildInputs = with pkgs; [
              fvm
              androidSdk_1
              jdk17
              chromium
            ];
            shellHook = paths + impure_hook;
          };

          # use prepackaged sdk
          android2 = pkgs.mkShell {
            ANDROID_SDK_ROOT = "${androidSdk_2}/libexec/android-sdk";
            CHROME_EXECUTABLE = chrome_path;
            buildInputs = with pkgs; [
              fvm
              androidSdk_2
              jdk17
              chromium
            ];
            shellHook = paths + impure_hook;
          };
        };
      }
    );
}
