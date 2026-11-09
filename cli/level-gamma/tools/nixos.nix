{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    perf
    pnpm
    nodejs
    nixpkgs-review
    hugo
  ];
}
