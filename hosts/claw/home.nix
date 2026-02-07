# Host: claw (Ubuntu Linux with Home Manager)
# For OpenClaw AI Agent Server
{ pkgs, username, ... }:
{
  # Home Manager needs this
  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "24.11";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Packages for claw server
  home.packages = with pkgs; [
    # Editors
    neovim
    
    # Git
    git
    git-crypt
    delta
    gh
    
    # CLI essentials
    ripgrep
    fd
    fzf
    bat
    eza
    zoxide
    tmux
    wget
    curl
    btop
    htop
    unzip
    direnv
    
    # Shell
    starship
    atuin
    
    # OpenClaw dependencies
    nodejs
    ffmpeg
    yt-dlp
    
    # Build tools
    gcc
    gnumake
    
    # Containers (podman = daemonless docker alternative)
    podman
    podman-compose
  ];

  # Shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "eza -la";
      cat = "bat";
      vim = "nvim";
      docker = "podman";
      docker-compose = "podman-compose";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Amine Kherbouche";
    userEmail = "kaminek92@gmail.com";
  };

  # Starship prompt
  programs.starship.enable = true;
  
  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BUN_INSTALL = "$HOME/.bun";
  };
  
  # Add bun to PATH
  home.sessionPath = [
    "$HOME/.bun/bin"
  ];
}
