#!/usr/bin/env zsh

if (( ! $+commands[kubectl] )); then
  return
fi

local COMPLETIONS_DIR="${0:A:h}/completions"

# Only regenerate completions if does not exist
if [[ ! -f "$COMPLETIONS_DIR/_kubectl" ]]; then
  kubectl completion zsh 2> /dev/null >| "$COMPLETIONS_DIR/_kubectl" &|
fi

# This command is used a LOT in daily life
alias k=kubectl

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)
