function coq-master
    set -l path (nix-prefetch-url --unpack 'https://github.com/coq/coq-on-cachix/tarball/master' --name source 2>&1 | tee /dev/stderr | grep -m1 '^path is' | cut -d\' -f2)
    set -l out "$HOME/tmp/.coq-master"

    nix-build "$path" --extra-substituters 'https://coq.cachix.org' --trusted-public-keys 'cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= coq.cachix.org-1:5QW/wwEnD+l2jvN6QRbRRsa4hBHG3QiQQ26cxu1F5tI=' -j auto -o $out
    set -x -p PATH $out/bin
    echo $out
end
