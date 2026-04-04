# Neovim Configuration

Personal Neovim configuration based on **AstroNvim v6** with `lazy.nvim` as the plugin manager.

## Features

- **AstroNvim v6** as the base distribution
- **LSP** with auto-signature help, diagnostics, and code actions
- **Autocompletion** via nvim-cmp + Copilot
- **Telescope/Snacks** pickers for files, buffers, git, and more
- **Terminal management** with custom tabbed terminal (`term_tabs.lua`)
- **OpenCode AI** integration with session management (`opencode_sessions.lua`)
- **ESLint & Formatting** via conform.nvim with range support
- **Transparent terminal** backgrounds and locked terminal/neo-tree windows

## Keymaps

See [KEYMAPS.md](KEYMAPS.md) for the full reference, including migration notes from NvChad.

Quick reference: `<Leader>` = `Space`. Press `<Space>` and wait to see the which-key menu.

## Structure

```
init.lua          # Bootstrap lazy.nvim
lua/
  lazy_setup.lua  # Plugin configuration
  polish.lua      # Custom commands & autocommands
  community.lua   # Community plugins
  plugins/        # Custom plugin specs
  custom/         # Custom modules (term_tabs, opencode_sessions)
```

## Getting Started

```bash
git clone https://github.com/marcosreuquen/nvim.git ~/.config/nvim
nvim  # lazy.nvim auto-installs on first run
```
