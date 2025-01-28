{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      hachimarupop
      noto-fonts-cjk-sans
      corefonts

      # I dont need all of them
      # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "Hack"];})
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
