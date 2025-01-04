.PHONY: packages
packages: $(BREW)

packages: $(BREW)
	$(BREW) install fzf
	$(BREW) install rg
	$(BREW) install fd
	$(BREW) install eza
	$(BREW) install ffmpeg
	$(BREW) install bat
	$(BREW) install curl
	$(BREW) install htop
	$(BREW) install jq
	$(BREW) install deno
# Casks
	$(BREW) install slack
	$(BREW) install brave-browser
	$(BREW) install linear-linear

