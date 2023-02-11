#!/usr/bin/env zsh

if (( ! $+commands[kubectl] )); then
  return
fi

# This command is used a LOT in daily life
alias k=kubectl

local COMPLETIONS_DIR="${0:A:h}/completions"

# Placeholder 'kubectl' shell function:
# Will only be executed on the first call to 'kubectl'
kubectl() {
  # Remove this function, subsequent calls will execute 'kubectl' directly
  unfunction "$0"

  # Only regenerate completions if does not exist or older than 24 hours
  if [[ ! -f "$COMPLETIONS_DIR/_kubectl" || ! $(find ~/.local/share/zap/plugins/zsh-kubectl/completions/_kubectl -newermt "24 hours ago" -print) ]]; then
    kubectl completion zsh 2> /dev/null >| "$COMPLETIONS_DIR/_kubectl" &|
  fi

  # Add completions to the FPATH
  typeset -TUx FPATH fpath
  fpath=("$COMPLETIONS_DIR" $fpath)

  # Execute 'kubectl' binary
  $0 "$@"
}
