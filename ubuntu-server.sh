#!/bin/bash

# Fetch repo from github
git clone https://github.com/redsuperbat/dotfiles ~/Versioned/dotfiles

# Setup symlinks
ln -ns ~/Versioned/dotfiles/.aliases ~/.aliases
ln -ns ~/Versioned/dotfiles/.functions ~/.functions
ln -ns ~/Versioned/dotfiles/.gitconfig ~/.gitconfig

sudo apt update
sudo apt upgrade -y

# Install docker
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
printf "Docker successfully installed! \n$(docker --version)\n"

# Install docker-compose
# Run this command to download the current stable release of Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose
printf "docker-compose sucessfully installed! \n$(docker-compose --version)\n"

# Autoremove unused packages
sudo apt autoremove -y
