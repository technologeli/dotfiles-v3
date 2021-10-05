#!/bin/bash
directories="alacritty aliases bash fish gitcongif nvim starship tmux vscode zsh"
for folder in $directories
do
  stow -R $folder
done
