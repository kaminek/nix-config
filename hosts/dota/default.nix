# Host: dota (MacBook - Darwin, computerName mbpro14-amine.kherbouche)
{ pkgs, lib, username, ... }:
{
  imports = [
    ../../modules/shared/packages.nix
    ../../modules/darwin/apps.nix
    ../../modules/nix-core.nix
    ../../modules/system.nix
    ../../modules/host-users.nix
  ];

  # Host-specific settings for dota
  # hostName/LocalHostName/NetBIOSName forbid dots; friendly computerName allows them
  networking.computerName = lib.mkForce "mbpro14-amine.kherbouche";
}
