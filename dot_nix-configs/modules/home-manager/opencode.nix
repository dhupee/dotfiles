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
    settings = {
      plugin = [
        "caveman-opencode-plugin"
      ];
      permission = {
        websearch = "allow";
        "context7_*" = "allow";
        "sentry_*" = "allow";
        "gh_grep_*" = "allow";
      };
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
        sentry = {
          type = "remote";
          url = "https://mcp.sentry.dev/mcp";
          oauth = {};
        };
        gh_grep = {
          type = "remote";
          url = "https://mcp.grep.app";
        };
      };
    };
  };

  # Environment variable for websearch tool
  home.sessionVariables.OPENCODE_ENABLE_EXA = "1";

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

  home.activation = {
    linkCaveman = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/opencode/caveman.json $HOME/.config/opencode/caveman.json
    '';
  };
}
