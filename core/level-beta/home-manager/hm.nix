{ pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cryolitia";
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/cryolitia" else "/home/cryolitia";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
