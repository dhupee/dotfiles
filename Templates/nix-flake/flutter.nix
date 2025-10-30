{
  description = "Nix Flake Template for Flutter Development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
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
            android_sdk.accept_license = true;
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

        # Cause the shell to be impure by default
        impure_hook = ''
          # impure by default
          export SHELL=$(which ${pkgs.zsh})
          echo 'Development Shell Initialized'
          exec zsh
        '';
      in {
        devShells = {
          # Web Only
          default = pkgs.mkShell {
            CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
            buildInputs = with pkgs; [
              flutter
              chromium
            ];
            shellHook = impure_hook;
          };

          # use fine-tuned sdk
          android1 = pkgs.mkShell {
            ANDROID_SDK_ROOT = "${androidSdk_1}/libexec/android-sdk";
            CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
            buildInputs = with pkgs; [
              flutter
              androidSdk_1
              jdk17
              chromium
            ];
            shellHook = impure_hook;
          };

          # use prepackaged sdk
          android2 = pkgs.mkShell {
            ANDROID_SDK_ROOT = "${androidSdk_2}/libexec/android-sdk";
            CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
            buildInputs = with pkgs; [
              flutter
              androidSdk_2
              jdk17
              chromium
            ];
            shellHook = impure_hook;
          };
        };
      }
    );
}
