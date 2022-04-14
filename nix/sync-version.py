#!/usr/bin/env python3

import re
import subprocess
import sys
from typing import Dict, Iterable, Tuple

PKG_MAP = {
    "coq": "coq_8_15",
    "coq.ctags": "coq-ctags",
    "glibc-locales": "glibcLocales",
    "vim-py3": "vim",
}
PKG_VERSION_RE = re.compile(r"(?P<pkg>[\w.-]+?)-(?P<ver>\d[\w.-]+)")
PKG_FILE = "packages.nix"


def read_packages(path: str) -> Dict[str, Dict[str, Tuple[str, str]]]:
    pkgs: Dict[str, Dict[str, Tuple[str, str]]] = {}
    hdr = None
    com = []
    with open(path, encoding="utf-8") as f:
        # Skip until list open
        for line in f:
            if "[" in line:
                break

        for line in f:
            if re.match(r"^\s*##", line) is not None:
                hdr = line.strip().strip("#").strip()
                pkgs[hdr] = {}
            elif not line.startswith("]"):
                assert hdr is not None
                if re.match(r"^\s*#", line) is not None:
                    com.append(line.strip())
                else:
                    pkg = line.strip().split()[0]
                    pkgs[hdr][pkg] = ("".join(com), "")
                    com = []
    return pkgs


def split_version(path: str) -> Tuple[str, str]:
    m = PKG_VERSION_RE.match(path)
    if m is None:
        return ("", "")
    return m.group("pkg"), m.group("ver")


def name2attr(pkg: str) -> str:
    return PKG_MAP.get(pkg, pkg)


def versions() -> Iterable[Tuple[str, str]]:
    res = subprocess.run(
        ["home-manager", "packages"],
        stdout=subprocess.PIPE,
        check=True,
    )
    return filter(
        lambda pkgver: pkgver[0] != "" and pkgver[1] != "",
        map(split_version, res.stdout.decode("utf-8").splitlines()),
    )


def tests() -> None:
    for name, ver in (
        ("coq", "8.6.5"),
        ("xmonad-with-packages", "8.10.7"),
        ("rust-analyzer", "2022-01-31"),
        ("vim-py3", "8.2.3457"),
    ):
        path = f"{name}-{ver}"
        assert split_version(path) == (name, ver)


if __name__ == "__main__":
    tests()
    quiet = "-q" in sys.argv

    pkgs = read_packages(PKG_FILE)

    indent = max(len(pkg) for sec in pkgs.values() for pkg in sec)
    assert indent > 0

    for pkg, ver in versions():
        pkg = name2attr(pkg)
        for sec in pkgs.values():
            if pkg in sec:
                sec[pkg] = (sec[pkg][0], ver)
                break
        else:
            if not quiet:
                print(f"{pkg} not found in {PKG_FILE}")

    out = ["pkgs:", "with pkgs; ["]
    for hdr in sorted(pkgs):
        out.append(f"  ## {hdr}")
        for pkg in sorted(pkgs[hdr]):
            com, ver = pkgs[hdr][pkg]
            assert ver != ""
            ind = indent - len(pkg) + 1
            if com != "":
                out.append(f"  {com}")
            out.append(f"  {pkg}{' ' * ind}# {ver}")
    out.append("]")

    with open(PKG_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(out) + "\n")
