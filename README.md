# zsh-vivid

vivid LS_COLORS for Zsh — Catppuccin theming and automatic theme synchronization.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![test](https://github.com/zsh-contrib/zsh-vivid/actions/workflows/test.yml/badge.svg)](https://github.com/zsh-contrib/zsh-vivid/actions/workflows/test.yml)

Give your file listings a consistent look across every tool that respects `LS_COLORS`. `zsh-vivid` generates and exports `LS_COLORS` via [vivid](https://github.com/sharkdp/vivid), picks up the active Catppuccin or custom theme automatically, and stays in sync with zsh-fzf and zsh-eza with zero extra configuration.

## Requirements

- [vivid](https://github.com/sharkdp/vivid) (`vivid`)

**macOS (Homebrew):**

```bash
brew install vivid
```

**Nix:**

```bash
nix profile install nixpkgs#vivid
```

## Installation

### Using zinit

```zsh
zinit load zsh-contrib/zsh-vivid
```

### Using sheldon

```toml
[plugins.zsh-vivid]
github = "zsh-contrib/zsh-vivid"
```

### Manual

```zsh
git clone https://github.com/zsh-contrib/zsh-vivid.git ~/.zsh/plugins/zsh-vivid
source ~/.zsh/plugins/zsh-vivid/zsh-vivid.plugin.zsh
```

## Configuration

### Theme Selection

Set `VIVID_THEME` before loading the plugin:

```zsh
export VIVID_THEME="catppuccin-mocha"  # default
```

### Theme Resolution Order

1. `VIVID_THEME` — if explicitly set
2. `FZF_THEME` — for consistency with zsh-fzf
3. `catppuccin-mocha` — default fallback

### Available Themes

Run `vivid themes` to list all themes. Commonly used:

| Theme | Description |
|-------|-------------|
| `catppuccin-latte` | Light Catppuccin theme |
| `catppuccin-frappe` | Dark Catppuccin (soft) |
| `catppuccin-macchiato` | Dark Catppuccin (medium) |
| `catppuccin-mocha` | Dark Catppuccin (deep) — default |
| `molokai` | Molokai color scheme |
| `one-dark` | One Dark theme |
| `nord` | Nord color scheme |

## Usage

### Basic

```zsh
# Just load the plugin — uses default theme
zinit load zsh-contrib/zsh-vivid
```

`LS_COLORS` is generated once at load time and picked up by `ls`, `tree`, `fd`, `eza`, and any other tool that reads it.

### Theme Synchronization

```zsh
# Share a theme across plugins
export FZF_THEME="catppuccin-macchiato"

zinit load zsh-contrib/zsh-fzf
zinit load zsh-contrib/zsh-vivid   # picks up FZF_THEME automatically
```

### Conditional Loading

```zsh
if (( $+commands[vivid] )); then
  zinit load zsh-contrib/zsh-vivid
fi
```

## Troubleshooting

**Colors not showing** — ensure your terminal supports 256 colors (`echo $TERM` should be `xterm-256color` or similar)

**Theme not found** — list available themes with `vivid themes`

**Changing themes** — `LS_COLORS` is generated at load time; reload your shell after switching: `exec zsh`

## The zsh-contrib Ecosystem

| Repo | What it provides |
|------|-----------------|
| [zsh-aws](https://github.com/zsh-contrib/zsh-aws) | AWS credential management with aws-vault and tmux |
| [zsh-eza](https://github.com/zsh-contrib/zsh-eza) | eza with Catppuccin and Rose Pine theming |
| [zsh-fzf](https://github.com/zsh-contrib/zsh-fzf) | fzf with Catppuccin and Rose Pine theming |
| [zsh-op](https://github.com/zsh-contrib/zsh-op) | 1Password CLI with secure caching and SSH key management |
| [zsh-tmux](https://github.com/zsh-contrib/zsh-tmux) | Automatic tmux window title management |
| **zsh-vivid** ← you are here | vivid LS_COLORS generation with theme support |

## License

[MIT](LICENSE) — Copyright (c) 2025 zsh-contrib

<!-- markdownlint-disable-file MD013 -->
