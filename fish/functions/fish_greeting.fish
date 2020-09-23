if command -qs proofaday
    function fish_greeting
        alias pyexec='env -u PYTHONNOUSERSITE pyenv exec'

        if not pyexec proofaday 2> /dev/null
            pyexec dproofaday -q start; pyexec dproofaday -q status -w
            pyexec proofaday
        end

        functions -e pyexec
    end
end
