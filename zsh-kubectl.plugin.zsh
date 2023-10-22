#!/usr/bin/env zsh

if (( ! $+commands[kubectl] )); then
  return
fi

# This command is used a LOT in daily life
alias k=kubectl

local COMPLETIONS_DIR="${0:A:h}/completions"

# Only regenerate completions if does not exist or older than 24 hours
if [[ ! -f "$COMPLETIONS_DIR/_kubectl" || ! $(find "$COMPLETIONS_DIR/_kubectl" -newermt "24 hours ago" -print) ]]; then
  kubectl completion zsh 2> /dev/null >| "$COMPLETIONS_DIR/_kubectl" &|
fi

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)
