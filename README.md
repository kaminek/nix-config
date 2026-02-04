# Nix Configuration

Multi-machine Nix configuration for macOS (Darwin) and Linux (Home Manager).

## Prerequisites

Install Nix using the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Machines

| Host | System | Type | Description |
|------|--------|------|-------------|
| `dota` | aarch64-darwin | nix-darwin | MacBook (macOS) |
| `claw` | x86_64-linux | home-manager | OpenClaw AI Agent Server (Ubuntu) |

## Structure

```
├── flake.nix              # Main flake configuration
├── hosts/
│   ├── dota/              # MacBook config (darwin)
│   │   └── default.nix
│   └── claw/              # Linux server config (home-manager)
│       └── home.nix
└── modules/
    ├── shared/            # Shared modules
    ├── darwin/            # macOS-specific (homebrew, etc)
    └── nixos/             # Linux-specific
```

## Usage

### macOS (dota)

```bash
# First time
nix run nix-darwin -- switch --flake .#dota

# Updates
darwin-rebuild switch --flake .#dota
```

### Ubuntu/Linux (claw)

```bash
# First time (installs home-manager)
nix run home-manager -- switch --flake .#claw

# Updates
home-manager switch --flake .#claw
```

## Adding Packages

- **macOS:** Edit `hosts/dota/default.nix` or `modules/darwin/apps.nix`
- **Linux:** Edit `hosts/claw/home.nix`

## Adding a New Machine

### For macOS
1. Create `hosts/<hostname>/default.nix`
2. Add to `darwinConfigurations` in `flake.nix`

### For Linux (non-NixOS)
1. Create `hosts/<hostname>/home.nix`
2. Add to `homeConfigurations` in `flake.nix`
