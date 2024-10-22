{config, pkgs, ...}:

{
  users.users.dhupee = {
    isNormalUser = true;
    description = "dhupee";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # just for the check dont get angry with me
  programs.zsh.enable = true;
}
