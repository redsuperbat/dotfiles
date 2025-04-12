skhd ?= $(CONFIG_DIR)/skhd/skhd.json

.PHONY: skhd
skhd: $(skhd)

$(skhd): $(BREW)
	$(BREW) install koekeishiya/formulae/skhd
	ln -his $(PWD)/skhd $(CONFIG_DIR)/skhd
	$(BIN_DIR)/skhd --install-service
	$(BIN_DIR)/skhd --start-service


