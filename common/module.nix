{ inputs, ... }:

home-config: [
  { nixpkgs.overlays = [ inputs.nur-cryolitia.overlays.nur-cryolitia ]; }

  inputs.nur.modules.nixos.default
  inputs.nixvim.nixosModules.nixvim

  inputs.home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = false;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.cryolitia = home-config;
  }
]
