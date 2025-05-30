TMUX = $(BIN_DIR)/tmux
TMUX_CONFIG_DIR = $(CONFIG_DIR)/tmux
TMS_CONFIG_DIR = $(CONFIG_DIR)/tms
TPM_DIR = $(TMUX_CONFIG_DIR)/plugins/tpm

.PHONY: tmux
tmux: $(TMUX)


$(TMUX): $(CONFIG_DIR) $(FISH)
	ln -his "$(PWD)/tmux" $(TMUX_CONFIG_DIR)
	ln -his "$(PWD)/tmux/tms" $(TMS_CONFIG_DIR)
	[ -d $(TPM_DIR) ] || git clone https://github.com/tmux-plugins/tpm $(TPM_DIR)
	# Ignore all errors
	$(BIN_DIR)/fish -c "sh -c '$(TPM_DIR)/bin/install_plugins'" || true
