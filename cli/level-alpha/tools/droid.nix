{ pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # (import ../formatter/package.nix { inherit pkgs; })
    openssh
    fastfetch
  ];
}
