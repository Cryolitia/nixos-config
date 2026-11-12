# nix build --impure --expr 'import ./hosts/xiaomi-piano/tests/default.nix'
let
  flake = builtins.getFlake ("path:" + toString ../../..);
  pkgs = import flake.inputs.nixpkgs {
    system = builtins.currentSystem;
    config.allowUnfree = true;
    overlays = host.nixpkgs.overlays;
  };
  host = import ../default.nix {
    inherit pkgs;
    inputs = flake.inputs;
    config = flake.nixosConfigurations.cryolitia-xiaomi-piano-nixos.config;
  };
  mangohud = pkgs.mangohud.override { lowerBitnessSupport = false; };
in
mangohud.overrideAttrs (old: {
  name = "mangohud-temperatures-check";
  outputs = [ "out" ];
  # Keep the complete production build cached independently of test changes.
  buildInputs = old.buildInputs ++ [ mangohud ];
  nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.python3 ];
  phases = [
    "unpackPhase"
    "patchPhase"
    "configurePhase"
    "buildPhase"
    "installPhase"
  ];
  buildPhase = ''
    python3 ${./run-temperatures.py} ${./mangohud-temperatures.cpp}
  '';
  installPhase = "touch $out";
})
