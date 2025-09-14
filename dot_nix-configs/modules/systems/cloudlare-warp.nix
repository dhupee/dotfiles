{pkgs, ...}: {
  environment.systemPackages = [pkgs.cloudflare-warp];
  systemd = {
    packages = with pkgs; [
      cloudflare-warp
    ];
    services.warp-svc.wantedBy = ["multi-user.target"];
  };
}
