{ pkgs, ... }:
{
  # Darwin-specific packages
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
      "google-cloud-sdk"
      "telegram"
      "discord"
      "slack"
    ];
  };
}
