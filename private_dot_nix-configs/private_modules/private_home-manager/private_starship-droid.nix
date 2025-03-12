{pkgs, ...}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        battery = {
          full_symbol = "• ";
          charging_symbol = "⇡ ";
          discharging_symbol = "⇣ ";
          unknown_symbol = "❓ ";
          empty_symbol = "❗ ";
        };
        nodejs = {
          symbol = "[⬢](bold green) ";
        };
      };
    };
  };
}
