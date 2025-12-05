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
  system.defaults.smb.NetBIOSName = hostname;

  # Use existing macOS user account (don't create or modify)
  system.primaryUser = username;

  nix.settings.trusted-users = [username];
}
