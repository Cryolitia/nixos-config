{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  environment.systemPackages = mkIf pkgs.stdenv.hostPlatform.isx86_64 (mkMerge [
    (mkIf (elem "nvidia" config.services.xserver.videoDrivers) (
      with pkgs;
      [
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
      ]
    ))

    (mkIf (!(elem "nvidia" config.services.xserver.videoDrivers)) (
      with pkgs;
      [
        (google-chrome.override {
          commandLineArgs = [
            # "--disable-gpu"
          ];
        })
      ]
    ))
  ]);
}
