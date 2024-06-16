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
  version = "unstable-2024-06-16";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "de4e837044f99286b6a079d7362b809e8a17f404";
    hash = "sha256-VFm9LpvQXkNB7CYa/DpJeICfdwgf2oXNfH1W2TFg5y0=";
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
