NEOVIM ?= $(BIN_DIR)/nvim

.PHONY: neovim
neovim: $(NEOVIM)

$(NEOVIM): $(BREW)
	$(BREW) install neovim
	ln -his $(PWD)/nvim $(CONFIG_DIR)/nvim

