{ inputs, ... }:
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.cryolitia.imports = [ ./hm.nix ];
  };
}
