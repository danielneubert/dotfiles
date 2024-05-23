# global variable for casks

function outdated
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_GREEN  "\033[0;32m"
    set -U COLOR_YELLOW "\033[0;33m"
    set -U COLOR_BLUE   "\033[0;34m"
    set -U COLOR_PURPLE "\033[0;35m"

    printf "%b" "$COLOR_YELLOW\e0[homebrew 🍻] Checking for outdated packages ...\n$COLOR_RESET"
    brew update -q

    brew outdated --formula --verbose | awk '{gsub(/[\(\)]/,"",$2); printf "%-20s %-20s %-20s\n", $1, $2, $4}'
    brew outdated --cask --greedy-auto-updates --verbose | awk '{gsub(/[\(\)]/,"",$2); printf "%-20s %-20s %-20s\n", $1, $2, $4}'

    printf "%b" "$COLOR_PURPLE\e0\n[composer 🎻] Checking for global composer dependencies ...\n$COLOR_RESET"
    composer global outdated

    printf "%b" "$COLOR_BLUE\e0\n[npm 📦] Checking for global npm dependencies ...\n$COLOR_RESET"
    npm outdated -g
end

# Alias to update brew, upgrade all packages and clean everything up afterwards
function update
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_GREEN  "\033[0;32m"
    set -U COLOR_YELLOW "\033[0;33m"
    set -U COLOR_BLUE   "\033[0;34m"
    set -U COLOR_PURPLE "\033[0;35m"

    printf "%b" "$COLOR_YELLOW\e0[homebrew 🍻] Updating the homebrew catalog ...\n$COLOR_RESET"
    brew update -q
    brew upgrade --formula -q
    brew upgrade --cask -q --greedy-auto-updates

    printf "%b" "$COLOR_YELLOW\e0[homebrew 🍻] Running the cleanup ...\n$COLOR_RESET"
    brew autoremove
    brew cleanup
    # brew doctor

    printf "%b" "$COLOR_PURPLE\e0\n[composer 🎻] Updating global composer dependencies ...\n$COLOR_RESET"
    composer global update

    printf "%b" "$COLOR_BLUE\e0\n[npm 📦] Updating global npm dependencies ...\n$COLOR_RESET"
    npm update -g

    printf "%b" "$COLOR_GREEN\e0\n[nvim 📝] Updating NeoVim Lazy Packages ...\n$COLOR_RESET"
    nvim --headless "+Lazy! sync" +qa
    nvim --headless "+MasonUpdate" +qa
    nvim --headless "+MasonToolsUpdate" +qa
    nvim --headless "+MasonToolsUpdateSync" +qa

    printf "%b" "$COLOR_GREEN\e0\nDONE! Do something amazing \u2764\n$COLOR_RESET"
end

alias ..cloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
