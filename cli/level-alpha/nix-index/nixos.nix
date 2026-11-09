{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
