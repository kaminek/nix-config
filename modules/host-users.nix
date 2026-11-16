{
  username,
  hostname,
  ...
} @ args:
#############################################################
#
#  Host & Users configuration
#
#############################################################
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  # ponytail: NetBIOSName unmanaged; writing com.apple.smb.server needs the
  # terminal to have Full Disk Access (macl-protected), value already set
  # system.defaults.smb.NetBIOSName = hostname;

  # Use existing macOS user account (don't create or modify)
  system.primaryUser = username;

  nix.settings.trusted-users = [username];
}
