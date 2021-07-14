{ pkgs ? import <nixpkgs> { } }:
with pkgs;

stdenv.mkDerivation {
  pname = "bitwise";
  version = "0.42";

  src = fetchFromGitHub {
    owner = "mellowcandle";
    repo = "bitwise";
    rev = "f70b6543981a8d56a567858197a9cfd7668878e6";
    sha256 = "154y0sn3z64z56k84ghsazkyihbkaz40hfwxcxdymnhvhh6m9f3g";
  };

  buildInputs = [ ncurses readline ];
  nativeBuildInputs = [ autoreconfHook ];
}
