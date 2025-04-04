#!/bin/bash

# Remember old merge conflicts and automactially resolve them
git config --global rerere.enabled true

# Set the SSH key path
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

# Check if the SSH key exists, and generate it if not
if [ ! -f "$SSH_KEY_PATH" ]; then
	echo "SSH key not found. Generating SSH key..."
	ssh-keygen -t ed25519 -f "$SSH_KEY_PATH" -N ""
else
	echo "SSH key already exists."
fi

# Configure Git to use SSH key for signing commits
git config --global gpg.format ssh
git config --global user.signingkey "$SSH_KEY_PATH"
git config --global commit.gpgsign true
