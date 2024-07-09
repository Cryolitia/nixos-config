{ inputs, ... }:

home-config: [
  { nixpkgs.overlays = [ inputs.nur-cryolitia.overlays.nur-cryolitia ]; }

  # {
  #   nixpkgs.config.packageOverrides = prev: {
  #     gnome = prev.gnome.overrideScope (
  #       _: _:
  #       let
  #         pkgs = inputs.nur-cryolitia.packages.${prev.system};
  #       in
  #       {
  #         mutter = pkgs.mutter-text-input-v1;
  #         gnome-shell = pkgs.gnome-shell-fix-preedit-cursor;
  #       }
  #     );
  #   };
  # }

  inputs.nur.nixosModules.nur
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
