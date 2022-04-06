{ pkgs ? import <nixpkgs> { }, vimVer ? "8.2", py ? "3", gui ? false }:
with pkgs;

let
  # NOTE: pin Python to 3.9 until https://github.com/vim/vim/issues/6183 is
  # fixed
  python = builtins.getAttr py {
    "2" = python27;
    "3" = python39;
  };
  vimSrc = builtins.getAttr vimVer {
    "7.4" = {
      patch = "2367";
      sha256 = "sha256-M/otUhUfKEqIMdsm4vdJKjBcWPo/CokSqwKTHaAeauQ=";
    };
    "8.0" = {
      patch = "1850";
      sha256 = "sha256-YNYKp1KWGsQ+LghcgneHYXXd1yKdMLVnEV4w+woyw5o=";
    };
    "8.1" = {
      patch = "2424";
      sha256 = "sha256-uQAbLYfq6Fyittic7YzjU17vUYTuhvNHgkvOUi5xNbU=";
    };
    "8.2" = {
      patch = "4700";
      sha256 = "sha256-P6CQQdXPcidhZ049FWvBqUPjM1xVg1cvGDA0En/YxRE=";
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
    "--x-includes=${xorg.libX11.dev}/include"
    "--x-libraries=${xorg.libX11.out}/lib"
  ];

  patches = if vimVer == "7.4" then [ ./vim7.4-if_python3.patch ] else null;

  enableParallelBuilding = true;
  hardeningDisable = [ "fortify" ];
}
