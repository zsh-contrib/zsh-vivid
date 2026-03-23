#!/usr/bin/env bats

# Tests for zsh-vivid plugin
#
# Requires bats-core: https://github.com/bats-core/bats-core
# Run: bats tests/plugin.bats

export PLUGIN_DIR
PLUGIN_DIR="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"

# ---------------------------------------------------------------------------
# LS_COLORS generation
# ---------------------------------------------------------------------------

@test "LS_COLORS is exported after loading" {
  run zsh -c '
    command -v vivid &>/dev/null || skip "vivid not installed"
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    [[ -n "$LS_COLORS" ]] && echo "set" || echo "unset"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "set" ]]
}

@test "LS_COLORS is non-empty after loading" {
  run zsh -c '
    command -v vivid &>/dev/null || skip "vivid not installed"
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "${#LS_COLORS}"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" -gt 0 ]]
}

@test "LS_COLORS uses stubbed vivid output" {
  run zsh -c '
    vivid() { echo "stub-colors-$*"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "stub-colors-generate catppuccin-mocha" ]]
}

# ---------------------------------------------------------------------------
# Theme resolution
# ---------------------------------------------------------------------------

@test "default theme is catppuccin-mocha" {
  run zsh -c '
    unset VIVID_THEME VIVID_THEME_DARK VIVID_THEME_LIGHT TMUX
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-mocha" ]]
}

@test "pre-set VIVID_THEME is respected" {
  run zsh -c '
    export VIVID_THEME="nord"
    unset VIVID_THEME_DARK VIVID_THEME_LIGHT TMUX
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "nord" ]]
}

@test "TMUX light mode uses VIVID_THEME_LIGHT" {
  run zsh -c '
    export TMUX="fake"
    unset VIVID_THEME VIVID_THEME_DARK VIVID_THEME_LIGHT
    tmux() { echo "light"; }
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-latte" ]]
}

@test "TMUX dark mode uses VIVID_THEME_DARK" {
  run zsh -c '
    export TMUX="fake"
    unset VIVID_THEME VIVID_THEME_DARK VIVID_THEME_LIGHT
    tmux() { echo "dark"; }
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-mocha" ]]
}

@test "custom VIVID_THEME_LIGHT is used in TMUX light mode" {
  run zsh -c '
    export TMUX="fake"
    export VIVID_THEME_LIGHT="catppuccin-frappe"
    unset VIVID_THEME VIVID_THEME_DARK
    tmux() { echo "light"; }
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-frappe" ]]
}

@test "custom VIVID_THEME_DARK is used in TMUX dark mode" {
  run zsh -c '
    export TMUX="fake"
    export VIVID_THEME_DARK="nord"
    unset VIVID_THEME VIVID_THEME_LIGHT
    tmux() { echo "dark"; }
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "nord" ]]
}

@test "outside TMUX VIVID_THEME is used directly" {
  run zsh -c '
    export VIVID_THEME="molokai"
    unset VIVID_THEME_DARK VIVID_THEME_LIGHT TMUX
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "molokai" ]]
}
