{ lib
, stdenvNoCC
, fetchFromGitHub
, gnome-themes-extra
, gtk-engine-murrine
, sassc
, gnome
}:
stdenvNoCC.mkDerivation {
  pname = "gruvbox-gtk-theme";
  version = "unstable-2024-06-18";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "5e99fc6c2b30b0489065254240f15cd6d401eb0b";
    hash = "sha256-wUBOR9CjjD2MwT3PdLw/mccVLYhwVCaTJ+fe2V2HhnE=";
  };

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  buildInputs = [
    gnome-themes-extra
    gnome.gnome-shell
    sassc
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    bash themes/install.sh -n Gruvbox -d $out/share/themes -t all
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gtk theme based on the Gruvbox colour pallete";
    homepage = "https://www.pling.com/p/1681313/";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.math-42 ];
  };
}
