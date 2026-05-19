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
      upgrade = false;
      cleanup = "zap";
    };

    masApps = { };

    taps = [
      "nikitabobko/tap"
      "modem-dev/tap"
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
      "rtk"
      "modem-dev/tap/hunk"
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
