{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  chromeSupported = meta.availableOn pkgs.stdenv.hostPlatform pkgs.google-chrome;
in
{
  environment.systemPackages = mkIf chromeSupported (mkMerge [
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
            "--enable-features=VaapiVideoDecodeLinuxGL"
            "--ozone-platform-hint=auto"
            "--enable-wayland-ime"
            "--gtk-version=4"
          ];
        })
      ]
    ))

    (mkIf (!(elem "nvidia" config.services.xserver.videoDrivers)) (
      with pkgs;
      [
        (google-chrome.override {
          commandLineArgs = [
            "--enable-features=VaapiVideoDecodeLinuxGL"
            "--ozone-platform-hint=auto"
            "--enable-wayland-ime"
            "--gtk-version=4"
            # "--disable-gpu"
          ];
        })
      ]
    ))
  ]);

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
