{ pkgs, inputs, ... }:

{
  environment.systemPackages = [ (import ./package.nix { inherit inputs pkgs; }) ];
  home-manager.users.cryolitia =
    { pkgs, ... }:
    {
      home.file."Library/Application Support/Code/User/settings.json".source = import ./settings.nix {
        inherit pkgs;
      };
    };
}
