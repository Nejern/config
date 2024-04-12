{ lib, stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "Gruvbox-icons";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "Nejern";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-3OuqAZRQkhfJP2vQu4sbj3W5GkX+QdXfLYYBVdwSnB0=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Gruvbox
    rm -rf README.md
    cp -r * $out/share/icons/Gruvbox
  '';

  meta = with lib; {
    description = "Gruvbox theme for GTK based desktop environments";
    homepage = "https://github.com/Nejern/Gruvbox-icons";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.nejern ];
  };
}
