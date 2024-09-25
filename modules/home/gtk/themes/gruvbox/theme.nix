{ lib
, stdenvNoCC
, fetchFromGitHub
, gnome-shell
, sassc
, gnome-themes-extra
, gtk-engine-murrine
, colorVariants ? [ ] # default: install all icons
}:
let
  pname = "gruvbox-gtk-theme";
  colorVariantList = [
    "dark"
    "light"
  ];
in
stdenvNoCC.mkDerivation {
  inherit pname;
  version = "unstable-2024-06-18";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "84c8a179a7aa6b8fa6672c17f98ea987455db5f3";
    hash = "sha256-Hep/V8dN8Wdm2U8HXZBuJsAazDkLggk2xRkxRoAeSkA=";
  };

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  nativeBuildInputs = [ gnome-shell sassc ];
  buildInputs = [ gnome-themes-extra ];

  dontBuild = true;

  postPatch = ''
    patchShebangs themes/install.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    bash themes/install.sh -n Gruvbox -c ${lib.concatStringsSep " " (if colorVariants != [] then colorVariants else colorVariantList)} -d $out/share/themes -t all --tweaks macos
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gtk theme based on the Gruvbox colour pallete";
    homepage = "https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme";
    license = lib.licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = [ maintainers.math-42 ];
  };
}
