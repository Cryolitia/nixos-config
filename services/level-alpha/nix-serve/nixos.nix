{ pkgs, ... }:
{
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    bindAddress = "*";
    secretKeyFile = "/var/lib/nix-serve-private";
  };
}
