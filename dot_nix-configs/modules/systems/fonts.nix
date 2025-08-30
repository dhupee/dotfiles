{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages =
      (with pkgs; [
        hachimarupop
        noto-fonts-cjk-sans
        corefonts
      ])
      # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
      ++ (with pkgs.nerd-fonts; [
        fira-code
        hack
      ]);

    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif" "Vazirmatn"];
        sansSerif = ["Ubuntu" "Vazirmatn"];
        monospace = ["Ubuntu Mono"];
      };
    };
  };
}
