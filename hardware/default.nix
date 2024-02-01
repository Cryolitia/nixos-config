{ ... }:

{
  imports =
    [
      ./sound.nix
      ./tpm.nix
    ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

}
