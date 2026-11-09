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

  # Secure Input (e.g. Ghostty on a sudo prompt) blocks AeroSpace hotkeys;
  # bring the app holding it to the front so the prompt is visible.
  # ponytail: 2s poll, macOS has no Secure Input change event
  launchd.user.agents.secure-input-focus = {
    script = ''
      last=
      while sleep 2; do
        pid=$(/usr/sbin/ioreg -d1 -w0 -l | grep -o '"kCGSSessionSecureInputPID"=[0-9]*' | head -1 | cut -d= -f2)
        if [ -n "$pid" ] && [ "$pid" != "$last" ]; then
          bid=$(/opt/homebrew/bin/aerospace list-apps --format '%{app-pid}|%{app-bundle-id}' | grep "^$pid|" | cut -d'|' -f2)
          echo "$(date '+%F %T') secure input: pid=$pid $(ps -o comm= -p "$pid") $bid"
          [ -n "$bid" ] && /usr/bin/open -b "$bid"
        fi
        last=$pid
      done
    '';
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/tmp/secure-input-focus.log";
      StandardErrorPath = "/tmp/secure-input-focus.log";
    };
  };

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
