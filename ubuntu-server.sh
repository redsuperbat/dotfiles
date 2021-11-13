#!/bin/bash

# Install oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup symlinks
ln -ns ~/versioned/dotfiles/.aliases ~/.aliases
ln -ns ~/versioned/dotfiles/.functions ~/.functions
ln -ns ~/versioned/dotfiles/.gitconfig ~/.gitconfig

sudo apt update
sudo apt upgrade -y

# Install docker
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
echo "Docker successfully installed! $(docker --version)"

# Install docker-compose
# Run this command to download the current stable release of Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose
printf "docker-compose sucessfully installed! \n$(docker-compose --version)\n"

# Autoremove unused packages
sudo apt autoremove -y
