if command -qs proofaday; and python -m pip freeze | grep -q proofaday
    function fish_greeting
        if not dproofaday status -q
            dproofaday start -q; dproofaday status -w -q
        end
        proofaday
    end
end
