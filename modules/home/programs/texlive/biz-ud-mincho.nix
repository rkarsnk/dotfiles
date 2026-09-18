# Morisawa BIZ UDMincho (OFL-1.1)。
# nixpkgs に biz-ud-gothic はあるが biz-ud-mincho はまだ存在しないため、
# 同じ構成(installFonts フック)で自前定義する。
{
  lib,
  stdenvNoCC,
  fetchzip,
  installFonts,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "biz-ud-mincho";
  version = "1.06";

  src = fetchzip {
    url = "https://github.com/googlefonts/morisawa-biz-ud-mincho/releases/download/v${finalAttrs.version}/morisawa-biz-ud-mincho-fonts.zip";
    hash = "sha256-TuNYguBCHkln8jbker/HxTNZS8cI1vJDRrT1PGmNSqE=";
  };

  sourceRoot = "${finalAttrs.src.name}/fonts";

  nativeBuildInputs = [ installFonts ];

  meta = {
    description = "Universal Design Japanese mincho font";
    homepage = "https://github.com/googlefonts/morisawa-biz-ud-mincho";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
})
