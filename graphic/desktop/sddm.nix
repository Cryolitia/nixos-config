{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "Nordic";
      autoNumlock = true;
      wayland.enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.nordic.sddm
  ];
}
