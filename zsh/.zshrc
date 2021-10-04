# ~/.zshrc
# https://github.com/technologeli/dotfiles-v2

# Tip: You can use the syntax above to avoid long if-statements.
# [[ condition ]] && execution
[[ $- != *i* ]] && return

# Import aliases.
[[ -a $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases
[[ -a $HOME/.aliases ]] && source $HOME/.aliases

# prevent duplicates in ~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS

# starship prompt
eval "$(starship init zsh)"