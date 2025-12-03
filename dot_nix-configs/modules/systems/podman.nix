{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      package = pkgs.podman;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      extraPackages = with pkgs; [
        docker-compose
        podman-compose
      ];
      dockerCompat = true;
      dockerSocket = {
        enable = true;
      };
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };
}
