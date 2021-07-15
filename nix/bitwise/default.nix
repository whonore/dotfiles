{ pkgs ? import <nixpkgs> { } }:
with pkgs;

stdenv.mkDerivation rec {
  pname = "bitwise";
  version = "0.42";

  src = fetchFromGitHub {
    owner = "mellowcandle";
    repo = "bitwise";
    rev = "${version}";
    sha256 = "154y0sn3z64z56k84ghsazkyihbkaz40hfwxcxdymnhvhh6m9f3g";
  };

  buildInputs = [ ncurses readline ];
  nativeBuildInputs = [ autoreconfHook ];
}
