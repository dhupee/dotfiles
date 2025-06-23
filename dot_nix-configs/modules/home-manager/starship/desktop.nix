let
  settings = builtins.fromTOML (builtins.readFile ../../../config/starship/plain-text-symbols.toml);
in
  {pkgs, ...}: {
    programs = {
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = settings;
      };
    };
  }
