#
# Config
#

# Rename to "Laptop"
sudo scutil --set ComputerName Laptop
sudo scutil --set LocalHostName Laptop

# Stealth Mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Never auto-allow apps
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

sudo pkill -HUP socketfilterfw

# Password after screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Unhide Library
chflags nohidden ~/Library

# Always show extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Save to Disc by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable Crash Reporter
defaults write com.apple.CrashReporter DialogType none

# Clean Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock


#
# Setup
#

# Download homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install basic formulas
brew install \
    caddy \
    dnsmasq \
    fisher \
    fzf \
    gnupg \
    httpstat \
    lsd \
    mas \
    neovim \
    node \
    openssh \
    stow \
    tmux \
    watch

# Install basic casks
brew install \
    1password \
    appcleaner \
    beeper \
    cryptomator \
    font-jetbrains-mono \
    fuse-t \
    fuse-t-sshfs \
    ghostty \
    linearmouse \
    monitorcontrol \
    obsidian \
    proton-mail \
    raycast \
    timemachineeditor \
    timemator \
    tower \
    transmit \
    viscosity \
    yubico-authenticator \
    yubico-yubikey-manager \
    zed

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
