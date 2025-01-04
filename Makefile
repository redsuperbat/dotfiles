default: neovim tmux ghostty fish packages

CONFIG_DIR ?= $(HOME)/.config

$(shell touch -t $(shell date -r $(shell stat -f '%B' $(CONFIG_DIR)) +"%Y%m%d%H%M.%S") $(CONFIG_DIR))

BIN_DIR_x86_64 = /usr/local/bin
BIN_DIR_arm64 = /opt/homebrew/bin
BIN_DIR = $(BIN_DIR_$(shell uname -m))

$(CONFIG_DIR):
	mkdir $(CONFIG_DIR) || true

# Homebrew
export HOMEBREW_NO_INSTALL_UPGRADE = 1
export HOMEBREW_NO_INSTALL_CLEANUP = 1
BREW ?= $(BIN_DIR)/brew
$(BREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: homebrew
homebrew: $(BREW)

include packages/packages.mk
include fish/fish.mk
include tmux/tmux.mk
include wezterm/wezterm.mk
include ghostty/ghostty.mk
include nvim/neovim.mk
