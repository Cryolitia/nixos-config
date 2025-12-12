{ pkgs, lib, ... }:
{
  imports = [
    ./owrx.nix
  ];

  boot.blacklistedKernelModules = [
    "sdr_msi3101"
    "msi001"
    "msi2500"
  ];

  environment.systemPackages = with pkgs; [
    wfview
    gridtracker2
    jtdx
    wsjtx
    tqsl
    gpredict
    qsstv
    gpsd
    (sdrpp.override { sdrplay_source = true; })
    sdrangel
    fldigi
  ];

  services.gpsd = {
    enable = true;
    devices = [
      "/dev/ttyACM1"
    ];
  };

  services.sdrplayApi.enable = true;

  systemd.services.sdrplayApi.serviceConfig.DynamicUser = lib.mkForce false;

  nixpkgs.overlays = [
    (final: prev: {
      soapysdrplay = prev.soapysdrplay.overrideAttrs (prev: {
        cmakeFlags = prev.cmakeFlags ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
      });
      soapysdr-with-plugins = prev.soapysdr.override { extraPackages = [ final.soapysdrplay ]; };
    })
  ];
}
