/*
NOTES:
- Install fonts here wherever you can
- For one off fonts, install it locally in `~/.local/share/fonts/`
- Run `fc-cache -fv` to recache the fonts
- Also, check https://wiki.nixos.org/wiki/Fonts
*/
{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages =
      (with pkgs; [
        hachimarupop
        noto-fonts-cjk-sans
        corefonts
      ])
      ++ (with pkgs.nerd-fonts; [
        # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
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
