# nix-darwin config

Declarative macOS system configuration using [nix-darwin](https://github.com/LnL7/nix-darwin) and flakes.

## What's managed

- **System packages** via Nix (neovim, git, docker, k8s tools, rust, go, etc.)
- **GUI apps** via Homebrew (Firefox, Chrome, Alacritty, Obsidian, etc.)
- **macOS settings** (dock, finder, trackpad, keyboard, dark mode)
- **Fonts** (Nerd Fonts, Font Awesome)
- **Services** (Tailscale)

## Prerequisites

1. Install [Nix](https://nixos.org/download.html)
2. Install [Homebrew](https://brew.sh)

## Usage

```bash
# Apply configuration
darwin-rebuild switch --flake .

# Build without applying
darwin-rebuild build --flake .

# Format nix files
nix fmt
```

## Structure

```
.
├── flake.nix           # Entry point, user vars
└── modules/
    ├── apps.nix        # Packages & Homebrew
    ├── system.nix      # macOS preferences
    ├── nix-core.nix    # Nix settings
    └── host-users.nix  # Host & user config
```

## Customization

1. Edit `flake.nix` for username/hostname
2. Edit `modules/apps.nix` for packages
3. Edit `modules/system.nix` for macOS settings
4. Run `darwin-rebuild switch --flake .`
