{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.kitty ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  home-manager.users.cryolitia = import ./hm.nix;
}
