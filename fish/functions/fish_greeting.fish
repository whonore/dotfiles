if command -q proofaday
    function fish_greeting
        alias pyexec="env -u PYTHONNOUSERSITE"

        if not pyexec proofaday -t1 2>/dev/null
            pyexec dproofaday -q start
            pyexec dproofaday -q status -w
            pyexec proofaday -t1
        end

        functions -e pyexec
    end
end
