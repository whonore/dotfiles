{
  description = "A system for parallelizing POSIX shell scripts";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      py-packages = ps: with ps; [ pexpect ];
      python = pkgs.python3.withPackages py-packages;
    in rec {
      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation rec {
        pname = "pash";
        version = "0.6";
        src = pkgs.fetchFromGitHub {
          fetchSubmodules = true;
          owner = "binpash";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-xDOMxrVvEyzA80SjX9jqf2RAO9NwuGfSXnv+UN4sZT8=";
        };

        buildInputs =
          [ dgsh-tee.x86_64-linux pkgs.autoconf pkgs.automake pkgs.libtool ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        propagatedBuildInputs = [ python ];

        postPatch = ''
          substituteInPlace compiler/parser/Makefile --replace "make" '$(MAKE)'
          substituteInPlace compiler/pash_init_setup.sh --replace "source ~/.pash_init" ""
        '';

        dontConfigure = true;

        buildPhase = ''
          runHook preBuild

          cd compiler/parser
          make -j $NIX_BUILD_CORES libdash
          cd ../../runtime
          make -j $NIX_BUILD_CORES eager split r-merge r-wrap r-split r-unwrap agg set-diff
          cd ..

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin/
          cp -r * $out/
          ln -s $out/pa.sh $out/bin/pa.sh
          cp ${dgsh-tee.x86_64-linux.out}/bin/dgsh-tee $out/runtime/

          runHook postInstall
        '';

        postFixup = let path = pkgs.lib.makeBinPath [ python ];
        in ''
          wrapProgram $out/bin/pa.sh --set PASH_TOP $out --prefix PATH : ${path}
          for prog in $out/pa.sh $out/compiler/pash_runtime.sh; do
            substituteInPlace $prog --replace "python3 -S" "python3"
          done
        '';

        meta = with pkgs.lib; {
          description = "A system for parallelizing POSIX shell scripts";
          homepage = "https://github.com/binpash/pash";
          license = with licenses; [ mit ];
        };
      };

      dgsh-tee.x86_64-linux = pkgs.stdenv.mkDerivation {
        pname = "dgsh-tee";
        version = "0.1";
        src = pkgs.fetchFromGitHub {
          owner = "tammam1998";
          repo = "dgsh";
          rev = "83f817fed23445c59405b250774efde3bec7ba72";
          sha256 = "sha256-E2CN59fW2aQ7JRSY+LrurNWh/p6MwoaQUfuNsEpYJzk=";
        };

        buildPhase = ''
          runHook preBuild

          cd core-tools/src
          gcc -Wall -O3 -DNDEBUG dgsh-tee.c negotiate.c dgsh-elf.s -o dgsh-tee

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin
          cp dgsh-tee $out/bin/

          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description =
            "Allows the expressive expression of efficient big data set and streams processing pipelines using existing Unix tools as well as custom-built components";
          homepage = "https://github.com/tammam1998/dgsh/tree/pash";
          license = with licenses; [ asl20 ];
        };
      };
    };
}
