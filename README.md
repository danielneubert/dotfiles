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

### Installer

Due to the fear of Logitech removing full support of the offline version of Logi Options+ (required for their ergo-mice) I saved the most recent available version of it to this repo. (offline version beeing 1.64 while the online version is already at 1.66 [2024-03-14])
