{ pkgs, ... }:
{
  # Darwin-specific packages (not available/needed on Linux)
  environment.systemPackages = with pkgs; [
    pam-reattach
    colima
  ];

  # Homebrew (macOS only)
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = { };

    taps = [
      "nikitabobko/tap"
    ];

    brews = [
      "curl"
      "aria2"
      "xh"
      "mise"
      "act"
      "tfenv"
      "zplug"
      "mysql-client"
      "prek"
      "libmagic"
    ];

    casks = [
      "firefox"
      "google-chrome"
      "alacritty"
      "ghostty"
      "karabiner-elements"
      "session-manager-plugin"
      "vlc"
      "obsidian"
      "google-drive"
      "nikitabobko/tap/aerospace"
      "virtualbox"
      "vagrant"
      "gcloud-cli"
      "ngrok"
      "codex"
      "flameshot"
      "stats"
      "telegram"
      "discord"
      "slack"
    ];
  };
}
