{pkgs, ...}: {
  programs = {
    starship = {
      enable = true;
      enableBashIntegration = true;
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
