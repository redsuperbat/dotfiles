FISH ?= $(BIN_DIR)/fish
FISHER = fish/fisher/functions/fisher.fish

.PHONY: fish
fish: $(FISH) $(FISHER)

$(FISH): $(CONFIG_DIR)
	ln -his $(PWD)/fish $(CONFIG_DIR)/fish
	sudo sh -c 'echo "/opt/homebrew/bin/fish" >> /etc/shells'
	sudo chsh -s /opt/homebrew/bin/fish $$(whoami)


$(FISHER): $(FISH)
	$(BIN_DIR)/fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update'

