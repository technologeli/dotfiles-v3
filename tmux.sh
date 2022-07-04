#!/bin/bash

sess="eli"

# attach and exit if exists
tmux attach -t "$sess" && exit 0

# start
tmux new-session -s "$sess" -d && tmux switch-client -t "$sess"


# window 1: dotfiles
tmux rename-window -t "$sess"
tmux rename-window -t "$sess" "dot"
tmux send-keys -t "$sess:dot" "nvim ~/dotfiles-v3/" C-m # enter


# display window 1
tmux select-window -t "$sess:dot"

# attach
tmux attach -t "$sess"
