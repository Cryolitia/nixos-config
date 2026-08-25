{ pkgs, ... }:

let
  zshrc = pkgs.writeText "zshrc" ''
    # Interactive Zsh configuration is managed system-wide in /etc/zshrc.
  '';
  btopConfig = pkgs.writeText "btop.conf" ''
    color_theme = "TTY"
    theme_background = False
  '';
  gpgConfig = pkgs.writeText "gpg.conf" ''
    ask-cert-level
    keyserver-options no-self-sigs-only
    keyserver-options no-import-clean
    armor
  '';
  dirmngrConfig = pkgs.writeText "dirmngr.conf" ''
    keyserver hkps://keyserver.ubuntu.com
    disable-ipv6
  '';
in

{
  systemd.user.tmpfiles.rules = [
    "d %h/.config 0755 - - - -"
    "d %h/.config/btop 0755 - - - -"
    "d %h/.gnupg 0700 - - - -"

    "L+ %h/.zshrc - - - - ${zshrc}"
    "L+ %h/.config/hyfetch.json - - - - ${../dotfiles/hyfetch.json}"
    "L+ %h/.config/btop/btop.conf - - - - ${btopConfig}"
    "L+ %h/.gnupg/gpg.conf - - - - ${gpgConfig}"
    "L+ %h/.gnupg/dirmngr.conf - - - - ${dirmngrConfig}"
  ];
}
