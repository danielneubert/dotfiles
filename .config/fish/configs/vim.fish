# Make the .config easily accessible everywhere
function nvim-temp
    set old_pwd $PWD
    set -g pwd_silent_change 1
    cd $argv[1]
    nvim $argv[2]
    cd $old_pwd
    set -g pwd_silent_change 0
end

# Access the SSH config
alias ..ssh='nvim-temp ~/.ssh config'

# Access the .config files
alias config='nvim-temp ~/.dotfiles/.config'

# Access the Obsidian vault
alias note='nvim-temp $OBSIDIAN_VAULT'
