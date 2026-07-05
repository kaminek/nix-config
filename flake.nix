{
  description = "Multi-machine Nix configuration (macOS + Linux)";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    # NixOS packages (for Linux)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Darwin packages (for macOS)
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    # Unstable channel — for fast-moving packages (e.g. yt-dlp)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Nix Darwin (macOS system management)
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Home Manager (for non-NixOS Linux like Ubuntu)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-unstable,
    darwin,
    home-manager,
    ...
  }: let
    # Shared user config
    username = "kaminek";
    useremail = "kaminek92@gmail.com";

    # Unstable pkgs sets, per system — used for fast-moving packages
    unstablePkgs = system:
      import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
  in {
    ##########################################################################
    # Darwin Configurations (macOS)
    ##########################################################################

    darwinConfigurations = {
      # MacBook - dota (hostName mbpro14, computerName mbpro14-amine.kherbouche)
      "dota" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs =
          inputs
          // {
            inherit username useremail;
            hostname = "mbpro14";
            pkgsUnstable = unstablePkgs "aarch64-darwin";
          };
        modules = [
          ./hosts/dota
        ];
      };
    };

    ##########################################################################
    # Home Manager Configurations (for non-NixOS Linux like Ubuntu)
    ##########################################################################

    homeConfigurations = {
      # OpenClaw Server - clawy (Ubuntu with home-manager)
      "clawy" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit username useremail;
          hostname = "clawy";
          pkgsUnstable = unstablePkgs "x86_64-linux";
        };
        modules = [
          ./hosts/clawy/home.nix
        ];
      };
    };

    ##########################################################################
    # Formatters
    ##########################################################################

    formatter = {
      "aarch64-darwin" = nixpkgs-darwin.legacyPackages."aarch64-darwin".alejandra;
      "x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    };
  };
}
