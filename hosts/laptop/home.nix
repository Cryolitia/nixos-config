{ config, pkgs, ... }:

{

    imports = [
        ../../graphic/home
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "684609BA7B5BC68D";
    };

    home.file.".config/maa".source = config.lib.file.mkOutOfStoreSymlink /home/cryolitia/nixos-config/maa;

}