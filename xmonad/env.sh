#!/bin/bash
set -euo pipefail

CPU_USAGE=$(for i in $(seq 0 $(($(nproc) - 1))); do printf "<total$i>%% "; done | sed -e "s/\s*$//")
export CPU_USAGE
