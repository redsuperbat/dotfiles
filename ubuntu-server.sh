#!/bin/bash

# Fetch repo from github
if [ -f ~/Versioned/dotfiles ]; then
  cd ~/Versioned/dotfiles
  git pull
  cd ~
else
  git clone https://github.com/redsuperbat/dotfiles ~/Versioned/dotfiles
fi

# Fetch repo from github
if [ -f ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile.bk
fi

# Setup symlinks
ln -ns ~/Versioned/dotfiles/.aliases ~/.aliases
ln -ns ~/Versioned/dotfiles/.functions ~/.functions
ln -ns ~/Versioned/dotfiles/.gitconfig ~/.gitconfig
ln -ns ~/Versioned/dotfiles/.bash_profile ~/.bash_profile

sudo apt update
sudo apt upgrade -y

REBOOT = false

# Install Docker
if [ ! -f /usr/bin/docker ]; then
  sudo apt install -y docker.io
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
  printf "Docker successfully installed! \n$(docker --version)\n"
  $REBOOT = true
else
  printf "Docker already installed."~
fi

# Install docker-compose
if [ ! -f /usr/local/bin/docker-compose ]; then
  # Run this command to download the current stable release of Docker Compose:
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  # Apply executable permissions to the binary
  sudo chmod +x /usr/local/bin/docker-compose
  printf "docker-compose sucessfully installed! \n$(docker-compose --version)\n"
else
  printf "docker-compose already installed."
fi

# Autoremove unused packages
sudo apt autoremove -y

if [ $REBOOT ]; then
  read -r -p "It is recommended to restart the computer after this install. Do you want to do it now? " response
  case "$response" in
  [yY][eE][sS] | [yY])
    sudo reboot
    ;;
  *)
    # Do nothing
    ;;
  esac
fi
