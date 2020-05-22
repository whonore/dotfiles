#!/usr/bin/env fish

set -l dir (dirname (status filename))

for sub in (find $dir -mindepth 2 -maxdepth 2 -type f -name install.fish)
    fish $sub
end
