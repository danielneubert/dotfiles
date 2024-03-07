# dotfiles

## Setup

### macOS

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git via brew (ARM & macOS 11+ version)
/opt/homebrew/bin/brew install git stow

# Setup Folder for Dotfiles
mkdir ~/.dotfiles

# Clone dotfiles
git clone https://github.com/danielneubert/dotfiles.git ~/.dotfiles

# Setup dotfiles via stow
/opt/homebrew/bin/stow ~/.dotfiles
```
