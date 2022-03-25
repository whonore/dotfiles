#!/usr/bin/env python3

import re
import subprocess
import sys
from typing import Iterable, Tuple

PKG_MAP = {
    "glibc-locales": "glibcLocales",
    "universal-ctags": "ctags",
    "vim-py3": "vim",
}
PKG_VERSION_RE = re.compile(r"[\w/]+-(?P<pkg>[\w.-]+?)-(?P<ver>\d[\w.-]+)")
PKG_FILE = "packages.nix"


def split_version(path: str) -> Tuple[str, str]:
    m = PKG_VERSION_RE.match(path)
    assert m is not None
    return m.group("pkg"), m.group("ver")


def parse_line(line: str) -> Tuple[str, str]:
    _, _, _, path = line.split(" ")
    return split_version(path)


def name2attr(pkg: str) -> str:
    return PKG_MAP.get(pkg, pkg)


def versions() -> Iterable[Tuple[str, str]]:
    res = subprocess.run(["nix", "profile", "list"], stdout=subprocess.PIPE, check=True)
    return map(parse_line, res.stdout.decode("utf-8").splitlines())


def tests() -> None:
    for name, ver in (
        ("coq", "8.6.5"),
        ("xmonad-with-packages", "8.10.7"),
        ("rust-analyzer", "2022-01-31"),
        ("vim-py3", "8.2.3457"),
    ):
        path = f"/nix/store/abc123-{name}-{ver}"
        assert split_version(path) == (name, ver)


if __name__ == "__main__":
    tests()
    quiet = "-q" in sys.argv

    with open(PKG_FILE, encoding="utf-8") as f:
        pkgs = f.read()

    indent = max(line.rfind(";") for line in pkgs.splitlines()) + 2
    assert indent > 0

    for pkg, ver in versions():
        pkg = name2attr(pkg)
        match = re.search(rf"(^.*?\b{pkg}\b.*;).*$", pkgs, flags=re.MULTILINE)
        if match is not None:
            assert indent > len(match.group(1))
            space = " " * (indent - len(match.group(1)))
            pkgs = re.sub(match.group(0), f"{match.group(1)}{space}# {ver}", pkgs)
        elif not quiet:
            print(f"{pkg} not found in {PKG_FILE}")

    with open(PKG_FILE, "w", encoding="utf-8") as f:
        f.write(pkgs)
