{ pkgs ? import <nixpkgs> {}, py ? "3" }:
with pkgs;

let pyv = if py == "3" then "3" else "";
    pyv_not = if py == "3" then "" else "3";
in stdenv.mkDerivation {
  name = "vim-py" + py;

  meta = {
    priority = 10 - builtins.fromJSON py;
  };

  src = fetchurl {
    url = https://github.com/vim/vim/archive/v8.0.1146.tar.gz;
    sha256 = "6ef5ada3970bf408239ab23edc5cdb0f815c9ed1b1d24363928c8b21ab4108c9";
  };

  buildInputs = [ncurses xorg.libX11 xorg.libXt]
                ++ (if py == "3" then [python36] else [python]);

  configureFlags = [
    "--with-features=huge"
    "--enable-cscope=yes"
    "--enable-multibyte=yes"

    "--enable-python${pyv}interp=yes"
    "--with-python${pyv}-config-dir=${if py == "3" then python36 else python}/lib"
    "--disable-python${pyv_not}interp"

    "--with-x"
    "--x-includes=${xlibs.libX11.dev}/include"
    "--x-libraries=${xlibs.libX11.out}/lib"
    "--disable-gui"

    "--enable-fail-if-missing"
  ];

  enableParallelBuilding = true;
  hardeningDisable = ["fortify"];
}
