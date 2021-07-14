#!/usr/bin/env python3

import re
import subprocess
from typing import Mapping, Tuple


PKG_MAP = {
    'universal-ctags': 'ctags',
    'vim-py3': 'vim',
}


def split_version(line: str) -> Tuple[str, str]:
    pkg, ver = line.rsplit('-', maxsplit=1)
    return PKG_MAP.get(pkg, pkg), ver


def versions() -> Mapping[str, str]:
    res = subprocess.run(["nix-env", "-q"], stdout=subprocess.PIPE, check=True)
    return dict(map(split_version, res.stdout.decode('utf-8').splitlines()))


if __name__ == "__main__":
    with open("packages.nix") as f:
        pkgs = f.read()
    for pkg, ver in versions().items():
        match = re.search(rf'(\b{pkg}.*;\s+# )[0-9.]+', pkgs)
        if match is not None:
            pkgs = re.sub(match.group(0), match.group(1) + ver, pkgs)
    with open('packages.nix', 'w') as f:
        f.write(pkgs)
