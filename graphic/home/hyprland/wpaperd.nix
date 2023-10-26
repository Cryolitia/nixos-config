{ config, ... }:

{
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/graphic/background";
        duration = "30m";
        sorting = "random";
      };
    };
  };
}
