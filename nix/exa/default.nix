{ exa, lib, fetchFromGitHub }:

exa.overrideAttrs (old: rec {
  name = "exa-${version}";
  version = "2021-08-12";

  src = fetchFromGitHub {
    owner = "ogham";
    repo = "exa";
    rev = "ef8fd32dc608669e23c6a9fd6f1afe5233f4c427";
    hash = "sha256-/Sk/Xg9NVwH9HDMo2Ymj6RZy5Z5X8e3PpH4dfHNdh6s=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    name = "${name}-vendor.tar.gz";
    inherit src;
    outputHash = "sha256-j6cCWwGcMJgLgsapyep5zXypLz17Y5/0TW1hXoWaOAE=";
  });
})
