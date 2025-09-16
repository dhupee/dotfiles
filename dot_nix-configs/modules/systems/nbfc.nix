# nbfc.nix
{pkgs, ...}: let
  filename = "nbfc.json";

  nitroConfig = ''
    {"SelectedConfigId": "Acer Nitro AN515-43"}
  '';
in {
  environment.systemPackages = with pkgs; [
    nbfc-linux
  ];
  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [pkgs.kmod];

    script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '/etc/${filename}'";

    wantedBy = ["multi-user.target"];
  };

  environment.etc."${filename}".text = nitroConfig;
}
