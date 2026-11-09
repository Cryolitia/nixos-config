{
  services.udev.extraRules = ''
    # Sony phone
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0fce", ATTRS{idProduct}=="320d", MODE="0666", GROUP="plugdev"

    # Keychron
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0666", TAG+="uaccess", GROUP="plugdev"
  '';
}
