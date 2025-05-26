NCSPOT ?= $(HOME)/.config/ncspot/config.toml

.PHONY: ncspot
ncspot: $(NCSPOT)

$(NCSPOT): $(BREW)
	$(BREW) install ncspot
	mkdir -p $(HOME)/.config/ncspot
	ln -his $(PWD)/ncspot/config.toml $(NCSPOT)
