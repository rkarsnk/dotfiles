# texlive/default.nix
# 日本語文書(upLaTeX)と英語論文(amsmath, graphicx 等)の両方に対応する構成。
# 必要なコレクション/パッケージを個別指定し、scheme-full の肥大化を避ける。
{ pkgs, ... }:
{
  home.packages = [
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium
        collection-langjapanese
        collection-fontsrecommended
        latexmk
        ;
    })
  ];
}
