function iscaps
    if command -q xset; and xset q >/dev/null 2>&1
        string match -r -q "\s*on" (xset q | grep Caps | cut -d: -f3)
    else
        false
    end
end
