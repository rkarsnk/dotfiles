# opencode.nix
# opencode は更新頻度が高いため、リリースブランチ(nixpkgs-26.05-darwin)ではなく
# nixpkgs-unstable のパッケージを直接引いている。
{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
  ];
}
