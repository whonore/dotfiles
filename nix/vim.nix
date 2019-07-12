{ pkgs ? import <nixpkgs> {}, py ? "3" }:
with pkgs;

let
  pyvars = {
    "2" = { ver = ""; notVer = "3"; py = python27; };
    "3" = { ver = "3"; notVer = ""; py = python36; };
  }.${py};
in stdenv.mkDerivation {
  name = "vim-py${py}";

  meta = {
    priority = 10 - builtins.fromJSON py;
  };

  src = fetchurl {
    url = https://github.com/vim/vim/archive/v8.0.1146.tar.gz;
    sha256 = "6ef5ada3970bf408239ab23edc5cdb0f815c9ed1b1d24363928c8b21ab4108c9";
  };

  buildInputs = [ncurses xorg.libX11 xorg.libXt pyvars.py];

  configureFlags = [
    "--with-features=huge"
    "--enable-cscope=yes"
    "--enable-multibyte=yes"

    "--enable-python${pyvars.ver}interp=yes"
    "--with-python${pyvars.ver}-config-dir=${pyvars.py}/lib"
    "--disable-python${pyvars.notVer}interp"

    "--with-x"
    "--x-includes=${xlibs.libX11.dev}/include"
    "--x-libraries=${xlibs.libX11.out}/lib"
    "--disable-gui"

    "--enable-fail-if-missing"
  ];

  enableParallelBuilding = true;
  hardeningDisable = ["fortify"];
}
