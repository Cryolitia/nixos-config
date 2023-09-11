{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.programs.chrome;

in {

  options = {
    programs.chrome = {

      enable = mkEnableOption(mdDoc "google-chrome");

      useGPU = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc "Use GPU";
      };

    };
  };

  config =  {

    environment.systemPackages = mkMerge[

      (mkIf (cfg.useGPU) (with pkgs; [
        (google-chrome.override {
          commandLineArgs = [
            "--enable-features=VaapiVideoDecoder"
            "--use-gl=egl"
            "--enable-features=VaapiIgnoreDriverChecks"
            "--disable-features=UseChromeOSDirectVideoDecoder"
            "--disable-features=UseSkiaRenderer"
            "--use-angle=vulkan"
            "--use-cmd-decoder=passthrough"
          ];
        })
      ]))

      (mkIf (!cfg.useGPU) (with pkgs; [
        (google-chrome.override {
          commandLineArgs = [
            "--disable-gpu"
          ];
        })
      ]))

    ];
  };

}