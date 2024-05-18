{ pkgs, ... }:

{
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard ];
}
