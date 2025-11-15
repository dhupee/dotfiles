{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker;
      extraPackages = with pkgs; [docker-compose];
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
