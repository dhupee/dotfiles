{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      hachimarupop
      noto-fonts-cjk
      corefonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif" "Vazirmatn"];
        sansSerif = ["Ubuntu" "Vazirmatn"];
        monospace = ["Ubuntu Mono"];
      };
    };
  };
}
