if command -qs proofaday; and python -m pip freeze | grep -q proofaday
    function fish_greeting
        proofaday
    end
end
