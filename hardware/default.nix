{ ... }:

{
  imports = [
    ./sound.nix
    ./tpm.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
