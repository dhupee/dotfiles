{
  config,
  pkgs,
  ...
}: {
  users.users = {
    dhupee = {
      isNormalUser = true;
      description = "dhupee";
      extraGroups = [
        "dialout"
        # "docker"
        "libvirtd"
        "networkmanager"
        "podman"
        "wheel"
      ];
      shell = pkgs.zsh;
      # packages = with pkgs; [
      #   firefox
      # ];
    };
  };

  # just for the check dont get angry with me
  programs.zsh.enable = true;
}
