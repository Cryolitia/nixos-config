{ pkgs, ... }:
{
  files = {
    # Keep the btop configuration directory as a regular directory.
    ".config/btop" = {
      type = "directory";
      permissions = "0755";
    };
    ".config/btop/btop.conf".source = pkgs.writeText "btop.conf" ''
      color_theme = "TTY"
      theme_background = False
    '';
  };
}
