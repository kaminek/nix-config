# Nix Configuration

Multi-machine Nix configuration: nix-darwin for macOS, Home Manager for non-NixOS Linux.

## Requirements

- Nix with flakes enabled. Install via [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer):
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- Git
- **macOS only:** [Homebrew](https://brew.sh) (used for GUI apps and casks)
- Clone this repo somewhere persistent (e.g. `~/work/perso/nix-config`)

## Machines

| Host | System         | Manager       | Description                       |
| ---- | -------------- | ------------- | --------------------------------- |
| dota | aarch64-darwin | nix-darwin    | MacBook (hostname mbpro14-amine.kherbouche) |
| clawy | x86_64-linux  | home-manager  | OpenClaw AI Agent Server (Ubuntu) |

## Layout

```
flake.nix              # inputs, outputs, host registry
hosts/
  <host>/              # per-host entry point
modules/
  shared/packages.nix  # packages shared across all hosts
  darwin/apps.nix      # macOS-only (homebrew, casks, brews)
  nix-core.nix         # nix daemon settings
  system.nix           # macOS system prefs
  host-users.nix       # user accounts
scripts/               # one-shot helper scripts
```

## Build & Apply

### macOS

```bash
# First time
nix run nix-darwin -- switch --flake .#dota

# Updates
sudo darwin-rebuild switch --flake .#dota
```

### Linux (home-manager)

```bash
# First time
nix run home-manager -- switch --flake .#clawy

# Updates
home-manager switch --flake .#clawy
```

Format Nix files: `nix fmt`

## Adding a New Machine

### macOS (nix-darwin)

1. Create `hosts/<hostname>/default.nix`:
   ```nix
   { pkgs, username, ... }: {
     imports = [
       ../../modules/shared/packages.nix
       ../../modules/darwin/apps.nix
       ../../modules/nix-core.nix
       ../../modules/system.nix
       ../../modules/host-users.nix
     ];
     networking.hostName = "<hostname>";
   }
   ```
2. Register in `flake.nix` under `darwinConfigurations`:
   ```nix
   "<hostname>" = darwin.lib.darwinSystem {
     system = "aarch64-darwin";
     specialArgs = inputs // {
       inherit username useremail;
       hostname = "<hostname>";
       pkgsUnstable = unstablePkgs "aarch64-darwin";
     };
     modules = [ ./hosts/<hostname> ];
   };
   ```
3. Apply: `nix run nix-darwin -- switch --flake .#<hostname>`

### Linux (home-manager)

1. Create `hosts/<hostname>/home.nix` (see `hosts/clawy/home.nix` for a working example — it accepts `pkgs`, `pkgsUnstable`, `username`).
2. Register in `flake.nix` under `homeConfigurations`:
   ```nix
   "<hostname>" = home-manager.lib.homeManagerConfiguration {
     pkgs = nixpkgs.legacyPackages.x86_64-linux;
     extraSpecialArgs = {
       inherit username useremail;
       hostname = "<hostname>";
       pkgsUnstable = unstablePkgs "x86_64-linux";
     };
     modules = [ ./hosts/<hostname>/home.nix ];
   };
   ```
3. Apply: `nix run home-manager -- switch --flake .#<hostname>`

## Adding Packages

- **Cross-platform:** `modules/shared/packages.nix`
- **macOS GUI / brews / casks:** `modules/darwin/apps.nix`
- **Bleeding-edge versions:** add to the `pkgsUnstable` block (already wired in `flake.nix`)

## Notes

- User identity (`username`, `useremail`) is set centrally in `flake.nix`.
- Unfree packages allowed via `nixpkgs.config.allowUnfree = true`.
- Activation hooks (e.g. setting VLC as default player) live in `modules/darwin/apps.nix`.
