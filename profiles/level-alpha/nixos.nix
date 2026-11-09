{ inputs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ../../core/level-alpha/system/nixos.nix
    ../../core/level-alpha/nix/nixos.nix
    ../../core/level-alpha/nixpkgs/nixos.nix
    ../../core/level-alpha/users/nixos.nix
    ../../core/level-alpha/network/nixos.nix
    ../../core/level-alpha/security/nixos.nix
    ../../core/level-alpha/dn42/nixos.nix
    ../../core/level-alpha/hjem/nixos.nix
    ../../cli/level-alpha/tools/nixos.nix
    ../../cli/level-alpha/zsh/nixos.nix
    ../../cli/level-alpha/git/nixos.nix
    ../../cli/level-alpha/gnupg/nixos.nix
    ../../cli/level-alpha/neovim/nixos.nix
    ../../cli/level-alpha/btop/nixos.nix
    ../../cli/level-alpha/hyfetch/nixos.nix
    ../../cli/level-alpha/nix-index/nixos.nix
    ../../cli/level-alpha/less/nixos.nix
    ../../cli/level-alpha/kmscon/nixos.nix
    ../../cli/level-alpha/network-tools/nixos.nix
    ../../cli/level-alpha/appimage/nixos.nix
    ../../cli/level-alpha/formatter/nixos.nix
    inputs.niri.nixosModules.niri
    ../../hardware/level-alpha/firmware/nixos.nix
    ../../hardware/level-alpha/udev/nixos.nix
  ];
}
