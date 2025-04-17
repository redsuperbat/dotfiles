NEOVIM ?= $(BIN_DIR)/nvim

.PHONY: neovim
neovim: $(NEOVIM)

$(NEOVIM):
	ln -his $(PWD)/nvim $(CONFIG_DIR)/nvim

