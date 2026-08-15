# taurus_viewer/default.nix
{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  package = inputs.taurus-viewer.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [ package ];

  # `package` はNix store配下(`$out/Applications`)にしか置かれず、
  # Launch Services / Spotlightからは見えないため、activation時に
  # ~/Applications/Home Manager Apps/ へシンボリックリンクする。
  home.activation.linkTaurusViewerApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/Applications/Home Manager Apps"
    run ln -sfn "${package}/Applications/taurus-viewer.app" "$HOME/Applications/Home Manager Apps/taurus-viewer.app"
  '';
}
