{ ... }:

{
  imports = [
    # ../../../graphic/desktop/gnome.nix
    ../../../graphic/desktop/niri.nix
  ];

  # specialisation."Nvidia".configuration = {
  #   imports = [
  #     ./nvidia.nix
  #   ];
  # };
}
