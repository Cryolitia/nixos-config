{ pkgs, ... }:
{
  files.".zshrc".source = pkgs.writeText "zshrc" ''
    # Interactive Zsh configuration is managed system-wide in /etc/zshrc.
  '';
}
