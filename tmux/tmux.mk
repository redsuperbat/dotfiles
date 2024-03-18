TMUX = $(BIN_DIR)/tmux
TMUX_CONFIG_DIR = $(CONFIG_DIR)/tmux
TPM_DIR = $(TMUX_CONFIG_DIR)/plugins/tpm

.PHONY: tmux
tmux: $(TMUX)


$(TMUX): $(BREW) $(CONFIG_DIR) $(FISH)
	( $(BREW) install tmux )
	ln -his "$(PWD)/tmux/tmux.conf" $(HOME)/.tmux.conf
	ln -his "$(PWD)/tmux" $(TMUX_CONFIG_DIR)
	[ -d $(TPM_DIR) ] || git clone https://github.com/tmux-plugins/tpm $(TPM_DIR)
	# Ignore all errors
	sh "$(TPM_DIR)/bin/install_plugins" || true
	rm -rf $(TMUX_CONFIG_DIR)/plugins/tmux/custom
	ln -his $(PWD)/tmux/custom $(TMUX_CONFIG_DIR)/plugins/tmux/custom
