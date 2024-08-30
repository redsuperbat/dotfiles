WEZTERM ?= $(BIN_DIR)/wezterm

.PHONY: wezterm
wezterm: $(WEZTERM)

$(WEZTERM): $(BREW)
	$(BREW) tap wez/wezterm
	$(BREW) install --cask wez/wezterm/wezterm
	ln -his $(PWD)/wezterm $(CONFIG_DIR)/wezterm
	touch $(WEZTERM)
