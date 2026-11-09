{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    (import ./packages.nix { inherit pkgs; })
    ++ (with pkgs; [
      fzf
      nixd
      typst
      cacert
    ]);
}
