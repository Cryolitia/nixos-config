{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    caffeine
    maccy
  ];

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      "com.apple.keyboard.fnState" = true;
    };
    loginwindow.GuestEnabled = false;
  };
}
