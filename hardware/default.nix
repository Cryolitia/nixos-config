{ pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./tpm.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = if pkgs.stdenv.hostPlatform.isx86_64 then true else false;
  };
}
