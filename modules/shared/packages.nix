{ pkgs, ... }:
{
  # Packages available on ALL systems (darwin + nixos)
  environment.systemPackages = with pkgs; [
    # Editors & Dev
    neovim
    git
    git-crypt
    delta
    
    # Languages & Runtimes
    nodejs
    bun
    go
    rustc
    cargo
    
    # CLI Tools
    ripgrep
    starship
    atuin
    eza
    zoxide
    bat
    direnv
    fd
    fzf
    lazygit
    tmux
    wget
    btop
    yt-dlp
    gh
    
    # DevOps
    docker
    terraform
    kubectl
    kubectx
    k9s
    kubernetes-helm
    
    # Cloud
    awscli2
  ];

  environment.variables.EDITOR = "nvim";
}
