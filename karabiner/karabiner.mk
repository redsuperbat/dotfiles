karabiner ?= $(CONFIG_DIR)/karabiner/karabiner.json

.PHONY: karabiner
karabiner: $(karabiner)

$(karabiner): $(BREW)
	$(BREW) install --cask karabiner-elements
	ln -his $(PWD)/karabiner $(CONFIG_DIR)/karabiner


