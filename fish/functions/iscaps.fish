function iscaps
    string match -r -q "\s*on" (xset q | grep Caps | cut -d: -f3)
end
