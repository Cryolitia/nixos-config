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

  inputs.nur.nixosModules.nur
]
