{
  pkgs,
  lib,
  config,
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
  home.file = {
    ".config/opencode/AGENTS.md" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/opencode/AGENTS.md";
    };
    ".local/share/opencode/auth.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/opencode/auth.json";
    };
    ".config/opencode/caveman.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/opencode/caveman.json";
    };
  };
}
