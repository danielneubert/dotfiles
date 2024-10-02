# Alias to update brew, upgrade all packages and clean everything up afterwards
function bup
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_GREEN  "\033[0;32m"
    set -U COLOR_YELLOW "\033[0;33m"

    printf "%b" "$COLOR_YELLOW\e0🍻  Updating the homebrew catalog ...\n$COLOR_RESET"
    brew update
    printf "%b" "$COLOR_YELLOW\e0🍻  Upgrading all installed packages (if needed) ...\n$COLOR_RESET"
    brew upgrade
    printf "%b" "$COLOR_YELLOW\e0🍻  Running the cleanup ...\n$COLOR_RESET"
    brew autoremove
    brew cleanup
    printf "%b" "$COLOR_GREEN\e0🍻  \u2714 Done! Do something amazing \u2764\n$COLOR_RESET"
end

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
