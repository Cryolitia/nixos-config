{ config, pkgs, ... }:

{

    imports = [
        ../../graphic/home
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "204B13F27C638936";
    };

}