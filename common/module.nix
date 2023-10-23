{ inputs, ... }:

[
  ({
    nixpkgs.overlays = [
      (final: prev: {
        nur-cryolitia = inputs.nur-cryolitia.packages."${prev.system}";
      })
      inputs.wayland.overlay
    ];
  })

  ../overlays/python3Packages-tpm2-pytss.nix

  inputs.nur.nixosModules.nur
]
