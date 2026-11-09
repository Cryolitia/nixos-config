{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    lazygit
  ];
  home-manager.users.cryolitia.imports = [ ./hm.nix ];
}
