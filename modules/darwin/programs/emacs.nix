# emacs.nix
# Cocoa(NS)版Emacsと mac-ime は、リリースブランチ(nixpkgs-26.05-darwin)に
# mac-ime が無いため nixpkgs-unstable から引いている。
{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = [
    # darwinでは pkgs.emacs がCocoa(NS)ビルドになる
    (
      (unstable.emacsPackagesFor unstable.emacs).emacsWithPackages (epkgs: [
        epkgs.mac-ime
        # ddskkなどを追加したい場合はここに足す
      ])
    )
  ];
}
