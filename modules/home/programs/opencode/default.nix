# opencode/default.nix
# opencode は更新頻度が高いため、リリースブランチ(nixpkgs-26.05-darwin)ではなく
# nixpkgs-unstable のパッケージを直接引いている。
# MacBookNeo にはインストールしない。
{
  pkgs,
  lib,
  inputs,
  hostName,
  ...
}:
{
  home.packages = lib.optionals (hostName != "MacBookNeo") [
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
  ];
}
