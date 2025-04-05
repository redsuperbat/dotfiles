lazygit ?= $(HOME)/Library/Application\ Support/lazygit/config.yml

.PHONY: lazygit
lazygit: $(lazygit)

$(lazygit): $(BREW)
	$(BREW) install lazygit
	mkdir -p $(HOME)/Library/Application\ Support/lazygit
	ln -his $(PWD)/lazygit/lazygit.yml $(lazygit)


