{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./hosts/rkarsnk.nix
    ../modules/home/home-shared.nix
  ];

}
