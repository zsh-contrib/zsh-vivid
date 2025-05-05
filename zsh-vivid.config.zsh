#!/usr/bin/env zsh

VIVID_THEME="${FZF_THEME:-$TMUX_THEME}"
VIVID_THEME="${FZF_THEME:-catppuccin-mocha}"

# shellcheck disable=SC2155
export LS_COLORS="$(vivid generate "${VIVID_THEME}")"
