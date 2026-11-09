{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    (import ./package.nix { inherit inputs pkgs; })
    pkgs.nixd
    pkgs.nixpkgs-fmt
  ];

  home-manager.users.cryolitia =
    { pkgs, ... }:
    {
      home.file.".config/Code/User/settings.json".source = import ./settings.nix { inherit pkgs; };
    };
}
