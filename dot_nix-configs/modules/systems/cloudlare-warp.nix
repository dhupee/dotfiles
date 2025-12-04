{pkgs, ...}: {
  services.cloudflare-warp = {
    enable = true;
    package = pkgs.cloudflare-warp;
    openFirewall = true;
  };
}
