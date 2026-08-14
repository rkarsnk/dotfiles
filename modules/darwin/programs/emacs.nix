# emacs.nix
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.emacs-macport

    # ddskkなどを追加したい場合は上の行を消してこちらを使う:
    # ((pkgs.emacsPackagesFor pkgs.emacs-macport).emacsWithPackages (epkgs: [ epkgs.ddskk ]))
  ];
}
