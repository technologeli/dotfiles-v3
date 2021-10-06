#!/bin/bash
directories="alacritty aliases bash fish gitconfig nvim starship tmux vscode zsh"
for folder in $directories
do
  stow -R $folder
done
