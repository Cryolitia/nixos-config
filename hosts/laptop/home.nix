{ config, pkgs, ... }:

{

    imports = [
        ../../graphic/home
        ../../graphic/home/hyprland.nix
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "684609BA7B5BC68D";
    };

    home.file.".config/maa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/maa";

}