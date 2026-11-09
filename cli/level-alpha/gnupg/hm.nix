{ lib, ... }:

{
  programs.gpg = {
    enable = true;
    settings = lib.mkForce {
      ask-cert-level = true;
      keyserver-options = [
        "no-self-sigs-only"
        "no-import-clean"
      ];
      armor = true;
    };
  };

  home.file.".gnupg/dirmngr.conf".text = ''
    disable-ipv6
    keyserver hkps://keyserver.ubuntu.com
  '';
}
