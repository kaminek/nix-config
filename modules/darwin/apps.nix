{
  pkgs,
  username,
  ...
}: {
  # Darwin-specific packages (not available/needed on Linux)
  environment.systemPackages = with pkgs; [
    pam-reattach
  ];

  # Set VLC as default media player on every activation (idempotent)
  system.activationScripts.setVlcDefault.text = ''
    if [[ -d "/Applications/VLC.app" ]]; then
      echo "Setting VLC as default media player..."
      sudo -u ${username} PATH=${pkgs.duti}/bin:$PATH \
        ${../../scripts/set_vlc_default.sh} || true
    fi
  '';

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
      "modem-dev/tap"
      "angristan/tap"
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
      "defuddle"
      "uv"
      "angristan/tap/fast-resume"
    ];

    casks = [
      "firefox"
      # "google-chrome" # managed by Jamf (installs as root:wheel), brew upgrade fails
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
      "stats"
      "telegram"
      "discord"
      "slack"
      "orbstack"
      "opensuperwhisper"
      "monitorcontrol"
    ];
  };
}
