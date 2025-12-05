{
  pkgs,
  lib,
  ...
}:
{
  nix = {
    # Determinate uses its own daemon to manage the Nix installation that
    # conflicts with nix-darwin's native Nix management.
    #
    # Using Determinate Nix, so nix-darwin management is disabled.
    # Nix settings must be configured in /etc/nix/nix.conf or via Determinate's tools.
    enable = false;
  };
}
