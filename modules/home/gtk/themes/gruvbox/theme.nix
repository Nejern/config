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
  version = "unstable-2024-06-12";

  src = fetchFromGitHub {
    #owner = "Fausto-Korpsvart";
    owner = "Nejern";
    repo = "Gruvbox-GTK-Theme";
    rev = "f9ac8992a1c9c3e72ee7c2ac472a8cda9b7d7dbf";
    hash = "sha256-D3kruTDd/iL3dbTCSLB1+LRzge2W3eWagaIhEoX0Il0=";
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
