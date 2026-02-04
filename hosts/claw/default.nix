# Host: claw (Ubuntu Linux - OpenClaw AI Agent Server)
{ pkgs, username, ... }:
{
  imports = [
    ../../modules/shared/packages.nix
    ../../modules/nixos/packages.nix
  ];

  # Host-specific settings for claw
  networking.hostName = "claw";
  
  # System settings for server
  time.timeZone = "UTC";
  
  # Enable SSH
  services.openssh.enable = true;
  
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 18789 ]; # SSH + OpenClaw gateway
  };
}
