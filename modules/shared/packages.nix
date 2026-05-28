{
  pkgs,
  pkgsUnstable,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core packages for ALL systems
  environment.systemPackages =
    (with pkgs; [
      # Editors
      neovim
      neovide

      # Git
      git
      git-crypt
      sops
      delta
      lazygit
      gh

      # CLI essentials
      coreutils-prefixed
      ripgrep
      fd
      fzf
      bat
      eza
      zoxide
      tmux
      wget
      btop
      direnv
      tokei
      dogdns
      dust
      skim
      fastfetch
      carapace

      # Shell
      starship
      atuin
      stow

      # Languages & tools
      nodejs
      bun
      go
      golangci-lint
      gotools
      ruby
      rustc
      cargo

      # Cloud & DevOps
      docker
      dive
      skopeo
      terraform
      terragrunt
      tflint
      ansible
      awscli2
      pulumi-bin
      tailscale

      # Kubernetes
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

      # Security
      rbw

      # Python
      (python3.withPackages (ps:
        with ps; [
          keyrings-google-artifactregistry-auth
        ]))

      # Task runners
      go-task
      just
      # Media
      ffmpeg
      duti
    ])
    ++ [
      # Fast-moving packages — pulled from nixpkgs-unstable
      # Wrap yt-dlp so it finds ffmpeg at runtime
      (pkgsUnstable.symlinkJoin {
        name = "yt-dlp-with-ffmpeg";
        paths = [pkgsUnstable.yt-dlp];
        nativeBuildInputs = [pkgsUnstable.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/yt-dlp \
            --add-flags "--ffmpeg-location ${pkgsUnstable.ffmpeg}/bin/ffmpeg"
        '';
      })
    ];

  environment.variables.EDITOR = "nvim";
}
