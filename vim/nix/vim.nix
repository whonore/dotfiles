{ pkgs ? import <nixpkgs> {}, py ? "3", vim ? "8.1" }:
with pkgs;

let
  pyVars = {
    "2" = { ver = ""; notVer = "3"; py = python27; };
    "3" = { ver = "3"; notVer = ""; py = python36; };
  }.${py};
  vimVars = {
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
      patch = "0141";
      sha256 = "060c82kpppzyla868r8nvm6srmx4ajnz7sc5hi0m55fs63qzkmqk";
    };
  }.${vim};
in stdenv.mkDerivation {
  name = "vim";

  src = with vimVars; fetchTarball {
    url = "https://github.com/vim/vim/archive/v${vim}.${patch}.tar.gz";
    inherit sha256;
  };

  buildInputs = [ncurses xorg.libX11 xorg.libXt pyVars.py]
                ++ lib.optionals stdenv.isDarwin [darwin.apple_sdk.frameworks.Cocoa];

  configureFlags = [
    "--with-features=huge"
    "--enable-cscope=yes"
    "--enable-multibyte=yes"

    "--enable-python${pyVars.ver}interp=yes"
    "--with-python${pyVars.ver}-config-dir=${pyVars.py}/lib"
    "--disable-python${pyVars.notVer}interp"

    "--disable-gui"

    "--enable-fail-if-missing"
  ] ++ lib.optionals (!stdenv.isDarwin) [
    "--with-x"
    "--x-includes=${xlibs.libX11.dev}/include"
    "--x-libraries=${xlibs.libX11.out}/lib"
  ];

  enableParallelBuilding = true;
  hardeningDisable = ["fortify"];
}
