# Nix Configuration

Multi-machine Nix configuration for macOS (Darwin) and Linux (NixOS).

## Machines

| Host | System | Description |
|------|--------|-------------|
| `dota` | aarch64-darwin | MacBook (macOS) |
| `claw` | x86_64-linux | OpenClaw AI Agent Server (Ubuntu/NixOS) |

## Structure

```
├── flake.nix              # Main flake configuration
├── hosts/
│   ├── dota/              # MacBook config
│   └── claw/              # Linux server config
└── modules/
    ├── shared/            # Packages for ALL systems
    │   └── packages.nix
    ├── darwin/            # macOS-specific (homebrew, etc)
    │   └── apps.nix
    ├── nixos/             # Linux-specific
    │   └── packages.nix
    ├── nix-core.nix       # Core nix settings
    ├── system.nix         # System settings
    └── host-users.nix     # User configuration
```

## Usage

### macOS (dota)

```bash
# First time
nix run nix-darwin -- switch --flake .#dota

# Updates
darwin-rebuild switch --flake .#dota
```

### Linux (claw)

```bash
# NixOS
sudo nixos-rebuild switch --flake .#claw

# Or with standalone nix on Ubuntu
nix build .#nixosConfigurations.claw.config.system.build.toplevel
```

## Adding Packages

- **All machines:** Edit `modules/shared/packages.nix`
- **macOS only:** Edit `modules/darwin/apps.nix`
- **Linux only:** Edit `modules/nixos/packages.nix`

## Adding a New Machine

1. Create `hosts/<hostname>/default.nix`
2. Add configuration to `flake.nix` under `darwinConfigurations` or `nixosConfigurations`
