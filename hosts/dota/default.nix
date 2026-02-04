# Host: dota (MacBook - Darwin)
{ pkgs, username, ... }:
{
  imports = [
    ../../modules/shared/packages.nix
    ../../modules/darwin/apps.nix
    ../../modules/nix-core.nix
    ../../modules/system.nix
    ../../modules/host-users.nix
  ];

  # Host-specific settings for dota
  networking.hostName = "dota";
}
