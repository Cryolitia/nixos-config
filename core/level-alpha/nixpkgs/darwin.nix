{ inputs, ... }:
{
  imports = [ inputs.nur.modules.darwin.default ];
  nixpkgs.overlays = [ inputs.nur-cryolitia.overlays.nur-cryolitia ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
}
