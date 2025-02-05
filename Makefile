default: packages fish ghostty neovim tmux

CONFIG_DIR ?= $(HOME)/.config

.PHONY: $(CONFIG_DIR)
$(CONFIG_DIR):
	mkdir -p $(CONFIG_DIR)

.PHONY: key-repeat
key-repeat:
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1

BIN_DIR_x86_64 = /usr/local/bin
BIN_DIR_arm64 = /opt/homebrew/bin
BIN_DIR = $(BIN_DIR_$(shell uname -m))

BREW ?= $(BIN_DIR)/brew

$(BREW):
	HOMEBREW_NO_INSTALL_UPGRADE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 \
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: homebrew
homebrew: $(BREW)

include packages/packages.mk
include fish/fish.mk
include tmux/tmux.mk
include ghostty/ghostty.mk
include nvim/neovim.mk
