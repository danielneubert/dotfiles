# iCloud Drive
alias ..cloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'

# List all outdated brew formulas, - casks, composer and npm packages
function outdated
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_GREEN  "\033[0;32m"
    set -U COLOR_YELLOW "\033[0;33m"
    set -U COLOR_BLUE   "\033[0;34m"
    set -U COLOR_PURPLE "\033[0;35m"

    printf "%b" "$COLOR_YELLOW\e0[brew 🍻] Searching for outdated packages ...\n$COLOR_RESET"
    brew update -q

    brew outdated --formula --verbose | awk '{gsub(/[\(\)]/,"",$2); printf "%-20s %-20s %-20s\n", $1, $2, $4}'
    brew outdated --cask --greedy-auto-updates --verbose | awk '{gsub(/[\(\)]/,"",$2); printf "%-20s %-20s %-20s\n", $1, $2, $4}'

    printf "%b" "$COLOR_BLUE\e0[node 📦] Searching for outdated packages ...\n$COLOR_RESET"
    npm outdated -g

    printf "%b" "$COLOR_GREEN\e0[nvim 📝] Searching for outdated Lazy packages ...\n$COLOR_RESET"
    nvim --headless "+Lazy! sync" +qa > /dev/null

    printf "%b" "$COLOR_PURPLE\e0[apple 🍏] Searching for outdated App Store apps ...\n$COLOR_RESET"
    mas outdated
end

# Alias to update brew, upgrade all brew packages, up
function update
    set -U COLOR_RESET  "\033[0m"
    set -U COLOR_GREEN  "\033[0;32m"
    set -U COLOR_YELLOW "\033[0;33m"
    set -U COLOR_BLUE   "\033[0;34m"
    set -U COLOR_PURPLE "\033[0;35m"

    printf "%b" "$COLOR_YELLOW\e0[brew 🍻] Updating Packages ...\n$COLOR_RESET"
    brew update -q > /dev/null
    brew upgrade --formula -q
    brew upgrade --cask -q --greedy-auto-updates

    printf "%b" "$COLOR_YELLOW\e0[brew 🍻] Running clean up ...\n$COLOR_RESET"
    brew autoremove
    brew cleanup

    printf "%b" "$COLOR_BLUE\e0\n[node 📦] Updating Packages ...\n$COLOR_RESET"
    npm update -g > /dev/null

    printf "%b" "$COLOR_GREEN\e0\n[nvim 📝] Updating Lazy Packages ...\n$COLOR_RESET"
    nvim --headless "+Lazy! sync" +qa > /dev/null
    nvim --headless "+Lazy! update" +qa > /dev/null
    printf "%b" "$COLOR_GREEN\e0[nvim 📝] Updating Mason Packages ...\n$COLOR_RESET"
    nvim --headless "+MasonUpdate" +qa > /dev/null
    printf "%b" "$COLOR_GREEN\e0\n[nvim 📝] Updating TS Server ...\n$COLOR_RESET"
    nvim --headless "+TSUpdate" +qa > /dev/null

    # Note: Additionally to `mas` Little Snitch needs these permissions:
    # - **`com.apple.CommerceKit.TransactionService`**: outgoing connection to `apple.com`
    # - **`storeassetd`**: outgoing connection to `apple.com`
    # - **`storedownloadd`**: outgoing connection to `apple.com`
    printf "%b" "$COLOR_PURPLE\e0\n[apple 🍏] Updating App Stroe apps ...\n$COLOR_RESET"
    mas upgrade

    printf "%b" "$COLOR_GREEN\e0\nDONE! Do something amazing \u2764\n$COLOR_RESET"
end
