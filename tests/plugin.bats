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
    unset FZF_THEME VIVID_THEME TMUX_THEME
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-mocha" ]]
}

@test "FZF_THEME is used as the vivid theme" {
  run zsh -c '
    export FZF_THEME="catppuccin-latte"
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "catppuccin-latte" ]]
}

@test "pre-set VIVID_THEME is not preserved (FZF_THEME takes precedence)" {
  # Documents actual behaviour: config.zsh overwrites VIVID_THEME with FZF_THEME
  run zsh -c '
    export VIVID_THEME="nord"
    unset FZF_THEME
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  # Without FZF_THEME, falls back to catppuccin-mocha regardless of VIVID_THEME
  [[ "$output" == "catppuccin-mocha" ]]
}

@test "FZF_THEME rose-pine-dawn is passed to vivid" {
  run zsh -c '
    export FZF_THEME="rose-pine-dawn"
    vivid() { echo "$2"; }
    source "$PLUGIN_DIR/zsh-vivid.plugin.zsh"
    echo "$LS_COLORS"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "rose-pine-dawn" ]]
}
