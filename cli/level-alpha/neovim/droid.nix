{
  config,
  pkgs,
  inputs,
  ...
}:

{
  environment.packages = [
    (inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvim (import ./config.nix { inherit inputs; }))
  ];
  environment.sessionVariables.EDITOR = "nvim";
}
