if command -qs proofaday
    function fish_greeting
        if not proofaday 2> /dev/null
            dproofaday -q start; dproofaday -q status -w
            proofaday
        end
    end
end
