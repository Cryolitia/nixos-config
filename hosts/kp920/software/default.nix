{ pkgs, ... }:

{
  imports = [
    ../../../common/software
    # ./syncthing.nix
    # ./samba.nix
    ./hydra.nix
    ../../../common/software/netdata.nix
  ];
}
