{ pkgs, ... }:
{
  # Core packages for ALL systems
  environment.systemPackages = with pkgs; [
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
    direnv
    
    # Shell
    starship
    atuin
  ];

  environment.variables.EDITOR = "nvim";
}
