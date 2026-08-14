# neovim.nix
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.neovim

  ];
}
