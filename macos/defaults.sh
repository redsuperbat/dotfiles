#!/bin/sh

# Sets reasonable macOS defaults.
# settings were grabbed from:
# https://github.com/holman/dotfiles/blob/master/macos/set-hostname.sh

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. Seriously this should be the default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write -g KeyRepeat -int 1
# Lower the time before macos starts repeating keys
defaults write -g InitialKeyRepeat -int 10

# Set the Finder preferences for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
defaults write com.apple.Safari.plist ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
defaults write com.apple.Safari.plist IncludeDevelopMenu -bool true
defaults write com.apple.Safari.plist WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari.plist "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true
