# texlive/default.nix
# 日本語文書(upLaTeX)と英語論文(amsmath, graphicx 等)の両方に対応する構成。
# 必要なコレクション/パッケージを個別指定し、scheme-full の肥大化を避ける。
{ pkgs, ... }:
let
  biz-ud-mincho = pkgs.callPackage ./biz-ud-mincho.nix { };
in
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
    # Morisawa BIZ UDGothic/UDMincho (OFL-1.1)。pxchfon の \setgothicfont/\setminchofont から利用する。
    pkgs.biz-ud-gothic
    biz-ud-mincho
    # Noto CJK (SIL OFL)。固定ウェイト版(-static)を使う。
    # 可変フォント版(noto-fonts-cjk-sans/serif)は NotoSansCJK-VF.otf.ttc 形式になり、
    # dvipdfmx がインスタンスを正しく埋め込めないため避ける。
    # pxchfon の noto-otc プリセット(\setminchofont/\setgothicfont)から利用する。
    pkgs.noto-fonts-cjk-sans-static
    pkgs.noto-fonts-cjk-serif-static
  ];

  # dvipdfmx (upLaTeX/pLaTeX) が pxchfon 経由で TTF/OTF フォントを見つけられるようにする。
  home.sessionVariables = {
    TTFONTS =
      "${pkgs.biz-ud-gothic}/share/fonts/truetype//:" + "${biz-ud-mincho}/share/fonts/truetype//:";
    OPENTYPEFONTS =
      "${pkgs.noto-fonts-cjk-sans-static}/share/fonts/opentype/noto-cjk//:"
      + "${pkgs.noto-fonts-cjk-serif-static}/share/fonts/opentype/noto-cjk//:";
  };
}
