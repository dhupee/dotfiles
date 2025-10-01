{
  pkgs,
  config,
  ...
}: {
  # ADB for connecting with Android
  programs.adb = {
    enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    android-studio-full
  ];

  # EULA
  nixpkgs.config.android_sdk.accept_license = true;

  # Udev Rules
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];
}
