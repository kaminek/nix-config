{ pkgs, ... }:
{
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    git-crypt
    sops
    delta
    ripgrep
    nodejs
    bun
    go
    golangci-lint
    gotools
    ruby
    rustc
    cargo
    docker
    terraform
    terragrunt
    tflint
    ansible
    awscli2
    google-cloud-sdk
    kubectl
    kubectx
    k9s
    kubebuilder
    kind
    kubelogin-oidc
    fluxcd
    argocd
    kustomize
    kubernetes-helm
    stow
    starship
    atuin
    eza
    zoxide
    bat
    direnv
    tokei
    dogdns
    dust
    fd
    skim
    lazygit
    lazydocker
    fastfetch
    tmux
    wget
    pre-commit
    btop
    go-task
    colima
    fzf
    pulumi-bin
    tailscale
    yt-dlp
    pam-reattach
    gh
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.
    };

    taps = [
      "nikitabobko/tap"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2" # download tool
      "xh" # http client (rust-based httpie alternative)
      "mise" # polyglot version manager
      "tfenv" # Terraform version manager
      "zplug" # Zsh plugin manager
      "mysql-client"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "firefox"
      "google-chrome"
      "alacritty"
      "ghostty"
      "karabiner-elements"
      "aws-vpn-client"
      "session-manager-plugin"
      "vlc"
      "obsidian"
      "google-drive"
      "nikitabobko/tap/aerospace"
      "virtualbox"
      "vagrant"

      # IM & audio & remote desktop & meeting
      "telegram"
      "discord"
    ];
  };
}
