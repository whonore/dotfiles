{ pkgs ? import <nixpkgs> { } }:
with pkgs;

rustPlatform.buildRustPackage rec {
  pname = "peridot";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "whonore";
    repo = pname;
    rev = "v${version}";
    sha256 = "0ilz6ry37v6nq7gr631abh8bjffsd69ra2429ad1lgmq6333i0jq";
  };

  cargoSha256 = "0dkyja8i7dkxn1pr9xpxlxfwx0sffn6xnwv9nylrscapvqmz68vf";

  meta = with lib; {
    description = "A dotfile manager";
    homepage = "https://github.com/whonore/peridot";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ whonore ];
  };
}
