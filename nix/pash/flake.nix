{
  description = "A system for parallelizing POSIX shell scripts";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    pash = system: let
      pkgs = nixpkgs.legacyPackages.${system};
      py-packages = ps: with ps; [pexpect];
      python = pkgs.python3.withPackages py-packages;

      dgsh-tee = pkgs.stdenv.mkDerivation {
        pname = "dgsh-tee";
        version = "0.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "binpash";
          repo = "dgsh";
          rev = "pash";
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

          install -Dm755 dgsh-tee "$out/bin/dgsh-tee"

          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Allows the expressive expression of efficient big data set and streams processing pipelines using existing Unix tools as well as custom-built components";
          homepage = "https://github.com/tammam1998/dgsh/tree/pash";
          license = with licenses; [asl20];
        };
      };
    in
      pkgs.stdenv.mkDerivation rec {
        pname = "pash";
        version = "0.7";
        src = pkgs.fetchFromGitHub {
          fetchSubmodules = true;
          owner = "binpash";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-uxfpHD8I3Gm+ifHGTSywOKjkG42GeWQHT8HA+C+nP28=";
        };

        buildInputs = [dgsh-tee pkgs.autoconf pkgs.automake pkgs.libtool];
        nativeBuildInputs = [pkgs.makeWrapper];
        propagatedBuildInputs = [python];

        postPatch = ''
          substituteInPlace compiler/parser/Makefile --replace "make" '$(MAKE)'
          substituteInPlace compiler/pash_init_setup.sh --replace "source ~/.pash_init" ""
        '';

        dontConfigure = true;

        buildPhase = ''
          runHook preBuild

          pushd compiler/parser/
          make -j $NIX_BUILD_CORES libdash
          popd
          pushd runtime/
          make -j $NIX_BUILD_CORES eager split r-merge r-wrap r-split r-unwrap agg set-diff
          popd

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p "$out/bin/" "$out/lib/"
          cp -r . "$out/lib/pash"
          ln -s "$out/lib/pash/pa.sh" "$out/bin/pa.sh"
          cp ${dgsh-tee.out}/bin/dgsh-tee "$out/lib/pash/runtime/"

          runHook postInstall
        '';

        postFixup = let
          python-path = pkgs.lib.makeBinPath [python];
        in ''
          wrapProgram "$out/bin/pa.sh" \
            --set PASH_TOP "$out/lib/pash/" \
            --prefix PATH : ${python-path}
          for prog in "$out/lib/pash/pa.sh" "$out/lib/pash/compiler/pash_runtime.sh"; do
            substituteInPlace $prog --replace "python3 -S" "python3"
          done
        '';

        meta = with pkgs.lib; {
          description = "A system for parallelizing POSIX shell scripts";
          homepage = "https://github.com/binpash/pash";
          license = with licenses; [mit];
          platforms = platforms.linux;
        };
      };
  in {
    packages.aarch64-linux.default = pash "aarch64-linux";
    packages.i686-linux.default = pash "i686-linux";
    packages.x86_64-linux.default = pash "x86_64-linux";
  };
}
