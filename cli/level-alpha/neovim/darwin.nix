{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    (inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvim (
      (import ./config.nix { inherit inputs; })
      // {
        clipboard.providers.wl-copy.enable = false;
      }
    ))
  ];
  environment.variables.EDITOR = "nvim";
}
