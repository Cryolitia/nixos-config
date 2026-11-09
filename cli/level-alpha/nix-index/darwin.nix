{ pkgs, inputs, ... }:

{
  environment.systemPackages = [ pkgs.comma ];
  home-manager.users.cryolitia.imports = [
    inputs.nix-index-database.homeModules.nix-index
    { programs.nix-index.enable = true; }
  ];
}
