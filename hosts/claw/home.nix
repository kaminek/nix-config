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
    
    # AI coding agents
    opencode
  ];

  # Shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "eza -la";
      cat = "bat";
      vim = "nvim";
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
  };
}
