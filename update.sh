#!/bin/bash
# Update packages, regardless of OS.

if [[ $(uname) = 'Darwin' ]]; then
  echo "OS: Mac" 
  brew update 
  brew upgrade 
elif [[ $(cat /etc/*release | grep ID_LIKE) == *"arch"* ]]; then 
  echo "OS: Arch" 
  sudo pacman -Syyu
  if [ -x /usr/bin/yay ]; then
    yay -Syu --noconfirm
  else
    echo "Warning: /usr/bin/yay does not exist."
  fi
elif [[ $(cat /etc/*release | grep ID_LIKE) == *"debian"* ]]; then 
  echo "OS: Debian" 
  # TODO
fi 
