FISH ?= $(BIN_DIR)/fish
FISHER = fish/fisher/functions/fisher.fish

.PHONY: fish
fish: $(FISH) $(FISHER)

$(FISH): $(BREW)
	ln -his $(PWD)/fish $(CONFIG_DIR)/fish
	$(BREW) install fish

$(FISHER): $(FISH)
	fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update'
	
