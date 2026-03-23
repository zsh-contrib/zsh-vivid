#!/usr/bin/env zsh

# Theme configuration
export VIVID_THEME="${VIVID_THEME:-catppuccin-mocha}"
export VIVID_THEME_DARK="${VIVID_THEME_DARK:-catppuccin-mocha}"
export VIVID_THEME_LIGHT="${VIVID_THEME_LIGHT:-catppuccin-latte}"

if [[ -n "$TMUX" ]]; then
  TMUX_CLIENT_THEME="$(tmux display -p "#{client_theme}")"

  if [[ "$TMUX_CLIENT_THEME" == "light" ]]; then
    export VIVID_THEME="$VIVID_THEME_LIGHT"
  else
    export VIVID_THEME="$VIVID_THEME_DARK"
  fi
fi

# shellcheck disable=SC2155
export LS_COLORS="$(vivid generate "${VIVID_THEME}")"
