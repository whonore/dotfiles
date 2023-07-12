#!/usr/bin/env python3

import re
import subprocess
import sys
from typing import Iterable

PKG_MAP = {
    "coq": "coq_8_17",
    "coq.ctags": "coq-ctags",
    "exa-unstable": "exa",
    "glibc-locales": "glibcLocales",
    "vim-py3": "vim",
}
PKG_VERSION_RE = re.compile(
    r"""
^
(?P<pkg>[\w.-]+?)
-
(?P<ver>\d[\w.+-]+?)
(?:-(?P<ext>[^\W\d][\w.]+))?
$
    """,
    re.VERBOSE,
)
PKG_FILE = "packages.nix"


def read_packages(path: str) -> tuple[list[str], dict[str, dict[str, tuple[str, str]]]]:
    preamble = []
    pkgs: dict[str, dict[str, tuple[str, str]]] = {}
    hdr = None
    com = []
    with open(path, encoding="utf-8") as f:
        # Skip until list open
        for line in f:
            preamble.append(line.rstrip())
            if line.strip() == 'builtins.filter supports [':
                break

        for line in f:
            if re.match(r"^\s*##", line) is not None:
                hdr = line.strip().strip("#").strip()
                pkgs[hdr] = {}
            elif not line.strip().startswith("]"):
                assert hdr is not None
                if re.match(r"^\s*#", line) is not None:
                    com.append(line.strip())
                else:
                    (pkg, _, ver) = line.strip().split()
                    pkgs[hdr][pkg] = ("".join(com), ver)
                    com = []
    return preamble, pkgs


def split_version(path: str) -> tuple[str, str] | None:
    m = PKG_VERSION_RE.match(path)
    if m is None:
        return None
    return m.group("pkg"), m.group("ver")


def name2attr(pkg: str) -> str:
    return PKG_MAP.get(pkg, pkg)


def versions() -> Iterable[tuple[str, str]]:
    res = subprocess.run(
        ["home-manager", "packages"],
        stdout=subprocess.PIPE,
        check=True,
    )
    return filter(None, map(split_version, res.stdout.decode("utf-8").splitlines()))


def tests() -> None:
    for name, ver, ext in (
        ("coq", "8.6.5", None),
        ("xmonad-with-packages", "8.10.7", None),
        ("rust-analyzer", "2022-01-31", "man"),
        ("vim-py3", "8.2.3457", None),
        ("shellcheck", "0.8.0", "doc"),
        ("alejandra", "3.0.0+20220815.91d4a0b", None),
    ):
        path = f"{name}-{ver}" if ext is None else f"{name}-{ver}-{ext}"
        msg = f"\nExpected: ({name}, {ver})\nGot:{split_version(path)}"
        assert split_version(path) == (name, ver), msg


if __name__ == "__main__":
    tests()
    quiet = "-q" in sys.argv

    preamble, pkgs = read_packages(PKG_FILE)

    indent = max(len(pkg) for sec in pkgs.values() for pkg in sec)
    assert indent > 0

    lpad = " " * (len(preamble[-1]) - 1)
    lpad = ""

    for pkg, ver in versions():
        pkg = name2attr(pkg)
        for sec in pkgs.values():
            if pkg in sec:
                sec[pkg] = (sec[pkg][0], ver)
                break
        else:
            if not quiet:
                print(f"{pkg} not found in {PKG_FILE}")

    out = preamble
    for hdr in sorted(pkgs):
        out.append(f"{lpad}  ## {hdr}")
        for pkg in sorted(pkgs[hdr]):
            com, ver = pkgs[hdr][pkg]
            assert ver != ""
            ind = indent - len(pkg) + 1
            if com != "":
                out.append(f"{lpad}  {com}")
            out.append(f"{lpad}  {pkg}{' ' * ind}# {ver}")
    out.append(f"{lpad}]")

    with open(PKG_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(out) + "\n")
