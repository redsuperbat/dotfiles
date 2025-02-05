FISH ?= $(BIN_DIR)/fish
FISHER = fish/fisher/functions/fisher.fish

.PHONY: fish
fish: $(FISH) $(FISHER)

$(FISH): $(BREW) $(CONFIG_DIR)
	ln -his $(PWD)/fish $(CONFIG_DIR)/fish
	$(BREW) install fish
	sudo sh -c 'echo "/opt/homebrew/bin/fish" >> /etc/shells'
	sudo chsh -s fish $$(whoami)


$(FISHER): $(FISH)
	$(BIN_DIR)fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update'

