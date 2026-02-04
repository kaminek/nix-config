{ pkgs, ... }:
{
  # NixOS/Linux-specific packages
  environment.systemPackages = with pkgs; [
    # System tools
    htop
    curl
    unzip
    
    # OpenClaw dependencies
    ffmpeg
    
    # Additional dev tools
    gcc
    gnumake
  ];

  # Enable Docker on Linux
  virtualisation.docker.enable = true;
}
