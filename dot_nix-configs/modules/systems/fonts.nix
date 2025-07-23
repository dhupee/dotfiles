{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      hachimarupop
      noto-fonts-cjk-sans
      corefonts

      # now there's easier way that override
      # not removing it yet
      nerd-fonts.fira-code
      nerd-fonts.hack

      # I dont need all of them
      # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
      # (pkgs.nerd-fonts.override {fonts = ["fira-code" "hack"];})
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
