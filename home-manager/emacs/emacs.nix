# emacs.nix
{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-macport;

    # ddskkを使う場合
    # extraPackages = epkgs: with epkgs; [ ddskk ];
  };
}
