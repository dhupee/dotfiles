{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      # tooling
      aaron-bond.better-comments
      golang.go
      charliermarsh.ruff
      editorconfig.editorconfig
      foxundermoon.shell-format
      hediet.vscode-drawio
      jnoortheen.nix-ide
      llvm-vs-code-extensions.vscode-clangd
      mads-hartmann.bash-ide-vscode
      ms-azuretools.vscode-docker
      ms-python.debugpy
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      oderwat.indent-rainbow
      vscodevim.vim
      yzhang.markdown-all-in-one

      # theming
      dracula-theme.theme-dracula
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "files.autoSave" = "afterDelay";
      "git.autoFetch" = true;
      "editor" = {
        "lineNumbers" = "relative";
        "formatOnSave" = true;
        "quickSuggesions" = {
          "comments" = "on";
          "strings" = "on";
        };
      };
      "nix" = {
        "enableLanguageServer" = true;
        "serverPath" = "${pkgs.nixd}/bin/nixd";
      };
    };
  };
}
