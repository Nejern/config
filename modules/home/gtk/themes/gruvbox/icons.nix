{ lib, stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "Gruvbox-icons";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Nejern";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Ke/vNw1BZhBmGzx4fF3mNMwBjyp5pYFkHIq4HVhT9Eg=";
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
