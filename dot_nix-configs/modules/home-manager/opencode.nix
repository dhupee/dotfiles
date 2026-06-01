{
  pkgs,
  lib,
  ...
}: {
  # Enabling opencode
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    enableMcpIntegration = true;
  };

  # Symlink
  home.activation = {
    linkOpencodeRules = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/opencode/AGENTS.md $HOME/.config/opencode/AGENTS.md
    '';
  };

  home.activation = {
    linkOpencodeAuth = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/opencode/auth.json $HOME/.local/share/opencode/auth.json
    '';
  };
}
