#!/bin/bash
set -euo pipefail

if command -v nproc; then
    NPROC=$(nproc)
else
    NPROC=$(sysctl -n hw.ncpu)
fi

CPU_USAGE=$(for i in $(seq 0 $(($NPROC - 1))); do printf "<total$i>%% "; done | sed -e "s/\s*$//")
export CPU_USAGE
