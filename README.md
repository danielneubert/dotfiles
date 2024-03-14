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

## Keyboard Setup

As it seems you can now remap the Caps-Lock to ESC, a shortcut I used for over 1,5 years now. This makes Karabiner finally obsolte for me.

To Setup:

![](assets/capslock-keyboard.gif)

## Software

### Logi Options+

Since my concerns about the imminent removal of the installer have been disproved, I have also found official release notes and download page for the offline installer. Since the offline version is not listed on homebrew, the download via the website is probably the only option for the time being.

- [Download Page Logi Options+ (Offline)](https://support.logi.com/hc/en-us/articles/11570501236119-Logitech-Options-offline-installer)
- [Release-Notes Logi Options+ (Offline)](https://support.logi.com/hc/en-us/articles/17032567939351-Logi-Options-Offline-Installer-Release-Notes)
