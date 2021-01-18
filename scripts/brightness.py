#!/usr/bin/env python3
import sys
from pathlib import Path
from typing import Optional


class Brightness:
    DIR = Path("/sys/class/backlight")

    def __init__(self) -> None:
        if not self.DIR.is_dir():
            raise ValueError(f"{self.DIR} is not a valid directory")
        dirs = list(self.DIR.iterdir())
        if len(dirs) != 1:
            raise ValueError(f"Found {dirs}, expected just one")
        self.dir = dirs[0]

    @property
    def max(self) -> int:
        return int((self.dir / "max_brightness").read_text())

    @property
    def val(self) -> int:
        return int((self.dir / "brightness").read_text())

    @val.setter
    def val(self, val: int) -> None:
        (self.dir / "brightness").write_text(str(val))

    @property
    def pct(self) -> float:
        return 100 * (self.val / self.max)

    @pct.setter
    def pct(self, val: float) -> None:
        self.val = int((val / 100) * self.max)


def main(pct: Optional[float] = None) -> None:
    br = Brightness()
    if pct is None:
        print(f"{br.pct:.2f}%")
    else:
        br.pct = pct


if __name__ == "__main__":
    try:
        if 1 < len(sys.argv):
            main(float(sys.argv[1]))
        else:
            main()
    except ValueError:
        print(f"Usage: {sys.argv[0]} [pct]")
