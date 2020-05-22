#!/usr/bin/env fish

blueper_colors

set -l name Blueper
set -l dconfdir /org/gnome/terminal/legacy/profiles:
set profile (dconf read $dconfdir/default | tr -d "'")
set -l profiledir $dconfdir/:$profile

set -l dname (dconf read $profiledir/visible-name)
if test $dname != "'$name'"
    echo "Default profile is $dname, not Blueper"
    exit
end

dconf write $profiledir/use-theme-colors "false"
dconf write $profiledir/bold-color-same-as-fg "true"
dconf write $profiledir/background-color "'#$blueper_black'"
dconf write $profiledir/foreground-color "'#$blueper_ice'"

set -l palette $blueper_black $blueper_red $blueper_green $blueper_yellow
set -a palette $blueper_blue $blueper_purple $blueper_teal $blueper_ice
set -a palette $blueper_darkgrey $blueper_red $blueper_green $blueper_yellow
set -a palette $blueper_blue $blueper_pink $blueper_teal $blueper_grey
set -l palette '[' (string replace -r -a '(\\w+)' '\'#$1\'' (string join ', ' $palette)) ']'
dconf write $profiledir/palette "$palette"
