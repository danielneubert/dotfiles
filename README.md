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

I found out that the `[⇧] Caps Lock` key can be mapped directly to the `[⎋] ESC` key with macOS. This makes the dependency on Karabiner obsolete for my setup.

Setup:

![](assets/capslock-keyboard.gif)

## Software

### Logi Options+

My concerns about the imminent removal of the offline installer for Logi Options+ have fortunately been put to rest. Logitech itself maintains a page with official release notes and a download page for the offline installer. Since the offline version is currently not listed on Homebrew, the download via the website is probably the only option for the time being.

- [Download Page Logi Options+ (Offline)](https://support.logi.com/hc/en-us/articles/11570501236119-Logitech-Options-offline-installer)
- [Release-Notes Logi Options+ (Offline)](https://support.logi.com/hc/en-us/articles/17032567939351-Logi-Options-Offline-Installer-Release-Notes)
