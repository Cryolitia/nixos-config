{ pkgs, ... }:
{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # https://github.com/NixOS/nixpkgs/pull/353230/files
    #yubikey-manager-qt
    #yubikey-manager
    pam_u2f
    pamtester
  ];

  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.pcscd.enable = true;
}
