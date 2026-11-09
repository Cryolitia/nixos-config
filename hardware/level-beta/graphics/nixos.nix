{ lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = if pkgs.stdenv.hostPlatform.isx86_64 then true else false;
  };
}
