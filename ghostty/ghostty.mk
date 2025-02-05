GHOSTTY ?= $(BIN_DIR)/ghostty

.PHONY: ghostty
ghostty: $(GHOSTTY)

$(GHOSTTY): $(BREW) $(CONFIG_DIR)
	$(BREW) install ghostty
	ln -his $(PWD)/ghostty $(CONFIG_DIR)/ghostty

