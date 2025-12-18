# zsh-vivid

A Zsh plugin for [vivid](https://github.com/sharkdp/vivid) integration that generates and exports `LS_COLORS` with theme support.

## Features

- Automatic `LS_COLORS` generation using vivid
- Catppuccin theme support (and all vivid themes)
- Theme synchronization with other zsh-contrib plugins
- Zero configuration required

## Requirements

- [vivid](https://github.com/sharkdp/vivid) - LS_COLORS generator

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

### Theme Fallback

The plugin resolves themes in this order:

1. `VIVID_THEME` - if explicitly set
2. `FZF_THEME` - for consistency with zsh-fzf
3. `catppuccin-mocha` - default fallback

### Available Themes

Run `vivid themes` to see all available themes. Common options:

| Theme | Description |
|-------|-------------|
| `catppuccin-latte` | Light Catppuccin theme |
| `catppuccin-frappe` | Dark Catppuccin (soft) |
| `catppuccin-macchiato` | Dark Catppuccin (medium) |
| `catppuccin-mocha` | Dark Catppuccin (deep) - default |
| `molokai` | Molokai color scheme |
| `snazzy` | Snazzy color scheme |
| `one-dark` | One Dark theme |
| `nord` | Nord color scheme |

## API Reference

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `VIVID_THEME` | `catppuccin-mocha` | Theme for color generation |
| `LS_COLORS` | (generated) | File type color configuration |

### Generated Output

The plugin exports `LS_COLORS` which is used by:

- `ls --color=auto`
- `tree`
- `fd`
- `exa` / `eza`
- Most file listing utilities

## Usage Examples

### Basic Usage

```zsh
# Just load the plugin - uses default theme
zinit load zsh-contrib/zsh-vivid

# ls now shows colored output
ls --color=auto
```

### Theme Synchronization

```zsh
# Use same theme across plugins
export FZF_THEME="catppuccin-macchiato"
export VIVID_THEME="$FZF_THEME"

zinit load zsh-contrib/zsh-fzf
zinit load zsh-contrib/zsh-vivid
```

### Conditional Loading

```zsh
# Only load if vivid is installed
if (( $+commands[vivid] )); then
  zinit load zsh-contrib/zsh-vivid
fi
```

## Directory Structure

```
zsh-vivid/
├── zsh-vivid.plugin.zsh   # Main entry point
├── zsh-vivid.config.zsh   # Theme configuration and LS_COLORS generation
├── README.md
└── LICENSE
```

## Troubleshooting

### Colors not showing

Ensure your terminal supports 256 colors or true color:

```zsh
echo $TERM  # Should be xterm-256color or similar
```

### Theme not found

List available themes:

```zsh
vivid themes
```

### Performance

LS_COLORS is generated once at plugin load time. If you change themes, reload your shell:

```zsh
exec zsh
```

## License

MIT License - see [LICENSE](./LICENSE) for details.
