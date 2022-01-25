{ pkgs ? import <nixpkgs> { }, vimVer ? "8.2", py ? "3", gui ? false }:
with pkgs;

let
  python = builtins.getAttr py {
    "2" = python27;
    "3" = python310;
  };
  vimSrc = builtins.getAttr vimVer {
    "7.4" = {
      patch = "2367";
      sha256 = "1r3a3sh1v4q2mc98j2izz9c5qc1a97vy49nv6644la0z2m92vyik";
    };
    "8.0" = {
      patch = "1850";
      sha256 = "16n3685gnc2y25kvac4x4bbxsxb1hxvq4p085qzc86lnaakhmmk0";
    };
    "8.1" = {
      patch = "2424";
      sha256 = "1d9mf4p55kjbh93z71pfhi8yypjkwf6fv76qnsi5rs7ahwnin05r";
    };
    "8.2" = {
      patch = "3457";
      sha256 = "070pffq48855dhkgdn4i0879pp3cqwgrqpwaarpyk1xcf0ig4kd6";
    };
  };
in stdenv.mkDerivation rec {
  pname = "vim-py${py}";
  version = "${vimVer}.${vimSrc.patch}";

  src = with vimSrc;
    fetchFromGitHub {
      owner = "vim";
      repo = "vim";
      rev = "v${version}";
      inherit sha256;
    };

  # NOTE: pin Python to 3.9 until https://github.com/vim/vim/issues/6183 is
  # fixed
  buildInputs = [ ncurses xorg.libX11 xorg.libXt python39 ]
    ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Cocoa ];

  configureFlags = [
    "--with-features=huge"
    "--enable-cscope=yes"
    "--enable-multibyte=yes"

    "--enable-python${if python.isPy3 then "3" else ""}interp=yes"
    "--with-python${if python.isPy3 then "3" else ""}-config-dir=${python}/lib"
    "--disable-python${if python.isPy3 then "" else "3"}interp"

    "--${if gui then "enable" else "disable"}-gui"

    "--enable-fail-if-missing"
  ] ++ lib.optionals (!stdenv.isDarwin) [
    "--with-x"
    "--x-includes=${xlibs.libX11.dev}/include"
    "--x-libraries=${xlibs.libX11.out}/lib"
  ];

  enableParallelBuilding = true;
  hardeningDisable = [ "fortify" ];
}
