{ pkgs, ... }:
pkgs.mkShell {
  packages = [
    pkgs.nix
    pkgs.home-manager
    pkgs.nil
  ];

  env = { };

  shellHook = ''
    echo "dotfiles devShell"
  '';
}
