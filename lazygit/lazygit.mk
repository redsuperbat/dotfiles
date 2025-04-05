lazygit ?= $(HOME)/Library/Application\ Support/lazygit/config.yml

.PHONY: lazygit
lazygit: $(lazygit)

$(lazygit): $(BREW)
	$(BREW) install lazygit
	ln -his $(PWD)/lazygit/lazygit.yml $(lazygit)


