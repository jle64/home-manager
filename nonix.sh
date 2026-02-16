#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

HOME_DIR="$HOME"
CONFIG_DIR="$HOME/.config"

declare -A FILES=(
  [".ansible.cfg"]="ansible/ansible.cfg"
  [".bash_logout"]="bash/bash_logout"
  [".bash_profile"]="bash/bash_profile"
  [".bashrc"]="bash/bashrc"
  [".dircolors"]="coreutils/dircolors"
  [".inputrc"]="readline/inputrc"
  [".profile"]="sh/profile"
  [".screenrc"]="screen/screenrc"
  [".shrc"]="sh/shrc"
  [".ssh/config"]="ssh/config"
)

for target in "${!FILES[@]}"; do
  src="${DOTFILES_DIR}/${FILES[$target]}"
  dst="${HOME_DIR}/${target}"

  echo ln -s "$src" "$dst"
done

CONFIG_DIRS=(
  fish
  kitty
  nushell
  nvim
  sway
  wezterm
  xkb
  xonsh
)

for dir in "${CONFIG_DIRS[@]}"; do
  src="$DOTFILES_DIR/$dir"
  dst="$CONFIG_DIR/$dir"

  echo ln -s "$src" "$dst"
done

