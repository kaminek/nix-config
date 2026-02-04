{ pkgs, ... }:
{
  # Linux server packages
  environment.systemPackages = with pkgs; [
    # System tools
    htop
    unzip
    
    # OpenClaw dependencies
    nodejs
    ffmpeg
    yt-dlp
    
    # Build tools
    gcc
    gnumake
  ];
}
