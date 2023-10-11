{ config, pkgs, ... }:

{

    imports = [
        ../../graphic/home
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "684609BA7B5BC68D";
    };

}