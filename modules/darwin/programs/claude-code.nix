# claude-code.nix
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.claude-code

  ];
}
