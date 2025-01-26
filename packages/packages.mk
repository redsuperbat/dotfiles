.PHONY: packages
packages: $(BREW)

packages: $(BREW)
	$(BREW) bundle --file $(PWD)/packages/Brewfile

