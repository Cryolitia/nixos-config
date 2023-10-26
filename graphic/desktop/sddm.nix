{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "Nordic/Nordic";
      autoNumlock = true;
      wayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs.libsForQt5; [
    plasma-framework
    qtgraphicaleffects
    plasma-workspace
    breeze-icons
  ];
}
