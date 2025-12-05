# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a nix-darwin configuration for macOS, managing system settings and packages using Nix flakes.

## Key Configuration

- **Username**: `amine.kherbouche` (defined in flake.nix:44)
- **Hostname**: `m4mbp` (defined in flake.nix:47)
- **System**: `aarch64-darwin` (Apple Silicon)
- **Nix version**: nixpkgs-25.05-darwin

## Building and Deploying

Since there is no Justfile in this repository, use standard nix-darwin commands:

```bash
# Build and activate the configuration
darwin-rebuild switch --flake .

# Build without activating
darwin-rebuild build --flake .

# Format nix files using alejandra
nix fmt
```

## Architecture

### Entry Point
`flake.nix` is the main entry point. It:
- Defines inputs (nixpkgs, nix-darwin)
- Sets user variables (username, email, hostname)
- Declares the darwinConfiguration that imports all modules
- Configures substituters (USTC and SJTU mirrors for faster downloads)

### Module Structure

**`modules/`** - System-level nix-darwin configuration:
- `nix-core.nix`: Core Nix settings (flakes enabled, garbage collection, substituters)
- `system.nix`: macOS system preferences (dock, finder, trackpad, keyboard, fonts)
- `apps.nix`: System packages and Homebrew configuration
- `host-users.nix`: Hostname and user configuration

### Homebrew Integration

Homebrew is used alongside Nix for GUI apps and packages that work better on macOS through brew. Configuration is in `modules/apps.nix`:
- `brews`: CLI tools installed via `brew install`
- `casks`: GUI applications installed via `brew install --cask`
- `masApps`: Mac App Store apps (requires manual initial installation)

## Important Notes

- **Flakes are enabled** in `modules/nix-core.nix:19-23`
- Homebrew must be installed manually before deploying (see https://brew.sh)
- The configuration uses Chinese mirror substituters (USTC, SJTU) for faster downloads
- TouchID is enabled for sudo authentication (`modules/system.nix:15`)
- Timezone is set to "Europe/Paris" (`modules/system.nix:18`)
- Garbage collection runs weekly, deleting generations older than 7 days (`modules/nix-core.nix:42-45`)

## Making Changes

1. Edit the relevant `.nix` files in `modules/`
2. Update username, email, hostname in `flake.nix` if needed
3. Run `darwin-rebuild switch --flake .` to apply changes
4. Format code with `nix fmt` before committing

## Network Proxy

If behind a proxy, see `scripts/darwin_set_proxy.py` for setting up proxy for Nix and Homebrew.
