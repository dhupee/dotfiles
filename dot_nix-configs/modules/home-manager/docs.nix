{
  pkgs,
  inputs,
  ...
}: let
  # Sources
  nixpkgs-source = inputs.nixpkgs-unstable;
  home-manager-source = inputs.home-manager;
in {
  home.file = {
    # DOCUMENTATION
    ".docs/nixpkgs-docs" = {
      source = "${nixpkgs-source}/doc";
    };
    ".docs/nixos-docs" = {
      source = "${nixpkgs-source}/nixos/doc/manual";
    };
    ".docs/home-manager-docs" = {
      source = "${home-manager-source}/docs/manual";
    };

    # MODULES
    ".docs/nixos-modules" = {
      source = "${nixpkgs-source}/nixos/modules";
    };
    ".docs/home-manager-modules" = {
      source = "${home-manager-source}/modules";
    };
  };
}
