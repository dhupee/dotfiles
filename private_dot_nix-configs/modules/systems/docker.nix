{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      extraPackages = with pkgs; [
        lazydocker
      ];
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
