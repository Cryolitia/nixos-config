{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "Nordic/Nordic";
      autoNumlock = true;
      wayland.enable = true;
      settings = {
        General = {
          GreeterEnvironment="QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192";
        };
      };
    };
  };

  environment.systemPackages = with pkgs.libsForQt5; [
    plasma-framework
    qtgraphicaleffects
    plasma-workspace
    breeze-icons
  ];
}