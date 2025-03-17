# Create the `la` alias for a more readable `ls`
alias la='lsd -l -A --tree --depth 1 --date relative --group-dirs first --blocks "name,size,date"'
alias vim='nvim'
alias lg='lazygit'

# Execute the `la` command when changing directories
function l --on-variable PWD
    if test "$pwd_silent_change" != "1"
        la
    end
end

# Add the user paths to the PATH
set -U fish_user_paths \
    /usr/local/bin \
    /opt/homebrew/sbin \
    /opt/homebrew/bin \
    /Users/daneu/.deno/bin \
    $HOME/.config/composer/vendor/bin \
    $HOME/.local/bin \
    $HOME/go/bin \
    $fisher_user_paths

builtin source $HOME/.config/fish/env.fish

set -gx XDG_CONFIG_HOME "$HOME/.config"

# Load all files within the configs directory
for config_file in (find $HOME/.config/fish/configs -path "*/*.fish" -depth 1 -type f)
    builtin source $config_file 2> /dev/null
end

# Remove the fish greeting
set fish_greeting

# Set the shell prompt
starship init fish | source
