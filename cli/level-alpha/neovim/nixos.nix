{ inputs, ... }:
{
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  programs.nixvim = {
    enable = true;
  }
  // (import ./config.nix { inherit inputs; });
  environment.variables.EDITOR = "nvim";
}
