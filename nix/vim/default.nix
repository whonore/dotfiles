{ pkgs ? import <nixpkgs> { }, version ? "8.2", py ? "3", gui ? false }:
with pkgs;

let
  python = builtins.getAttr py {
    "2" = python27;
    "3" = python36;
  };
  vimSrc = builtins.getAttr version {
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
      patch = "1770";
      sha256 = "14mbrbnjwb8r4pl06vafd56x0pmbcgqvr57s2ns2arh7xcy9bri7";
    };
  };
in stdenv.mkDerivation {
  name = "vim-${version}.${vimSrc.patch}-py${py}";

  src = with vimSrc;
    fetchTarball {
      url = "https://github.com/vim/vim/archive/v${version}.${patch}.tar.gz";
      inherit sha256;
    };

  buildInputs = [ ncurses xorg.libX11 xorg.libXt python ]
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
