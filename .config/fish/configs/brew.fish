# Alias to list all installed brew packages without dependencies
function bls
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_YELLOW "\033[0;33m"

    printf "%b" "$COLOR_YELLOW\e0🍻  Formulas:\n$COLOR_RESET"
    brew leaves | column -c $(tput cols)
    echo ""
    printf "%b" "$COLOR_YELLOW\e0🍻  Casks:\n$COLOR_RESET"
    brew list --cask
end

# Alias to list all installed brew packages with dependencies
function blsa
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_YELLOW "\033[0;33m"

    printf "%b" "$COLOR_YELLOW\e0🍻  Listing all formulas and their dependencies ...\n$COLOR_RESET"
    brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
end
