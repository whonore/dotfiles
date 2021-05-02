# Redefine vint to filter out spurious error
function vint
    for line in (command vint $argv)
        if string match --quiet --invert --regex 'Undefined variable: ([^ ]*):' $line
            echo $line
        end
    end
end
