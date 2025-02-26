{ pkgs, ... }:

{
  imports = [
    ../../../common/software
    ../../../common/software/netdata.nix
  ];
}
