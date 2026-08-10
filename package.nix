{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "dotfiles-info";
  runtimeInputs = [ pkgs.coreutils ];
  text = ''
    echo "dotfiles flake"
    echo "hosts: MacBookNeo, MacMiniM4"
  '';
}
