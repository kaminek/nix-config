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

    # Nix Darwin (macOS system management)
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-darwin,
    darwin,
    ...
  }: let
    # Shared user config
    username = "kaminek";
    useremail = "kaminek92@gmail.com";
  in {
    ##########################################################################
    # Darwin Configurations (macOS)
    ##########################################################################
    
    darwinConfigurations = {
      # MacBook - dota
      "dota" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = inputs // {
          inherit username useremail;
          hostname = "dota";
        };
        modules = [
          ./hosts/dota
        ];
      };
    };

    ##########################################################################
    # NixOS Configurations (Linux)
    ##########################################################################
    
    nixosConfigurations = {
      # OpenClaw Server - claw
      "claw" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs // {
          inherit username useremail;
          hostname = "claw";
        };
        modules = [
          ./hosts/claw
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
