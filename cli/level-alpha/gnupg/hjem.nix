{ pkgs, ... }:
{
  files = {
    # Preserve the private directory and its restricted permissions.
    ".gnupg" = {
      type = "directory";
      permissions = "0700";
    };
    ".gnupg/gpg.conf".source = pkgs.writeText "gpg.conf" ''
      ask-cert-level
      keyserver-options no-self-sigs-only
      keyserver-options no-import-clean
      armor
    '';
    ".gnupg/dirmngr.conf".source = pkgs.writeText "dirmngr.conf" ''
      keyserver hkps://keyserver.ubuntu.com
      disable-ipv6
    '';
  };
}
